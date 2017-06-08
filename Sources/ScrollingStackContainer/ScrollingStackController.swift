//  ScrollingStackController
//  Efficient Scrolling Container for UIViewControllers
//
//  Created by Daniele Margutti.
//  Copyright © 2017 Daniele Margutti. All rights reserved.
//
//	Web: http://www.danielemargutti.com
//	Email: hello@danielemargutti.com
//	Twitter: @danielemargutti
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation
import UIKit

private class StackItem {
	
	/// Managed UIViewController instance
	var controller: UIViewController
	/// Appearance to use when view controller is inside the ScrollingStackController instance
	var appearance: ScrollingStackController.ItemAppearance
	/// This is the regular rect of the item into the stack
	/// Be careful: this is not the real rect due the fact it will be adjusted as the parent
	/// scroll in order to keep healthy memory usage.
	var rect: CGRect = .zero
	
	/// Initialize a new stack item to manage a view controller instance
	///
	/// - Parameters:
	///   - controller: view controller instance to manage
	///   - appearance: appearance to set when contained in a scrolling stack
	init(_ controller: UIViewController, _ appearance: ScrollingStackController.ItemAppearance) {
		self.controller = controller
		self.appearance = appearance
	}
}

extension UIView {
	
	/// Helper method to get the first height constraint set for an instance of UIView
	public var heigthConstraint: NSLayoutConstraint? {
		return self.constraints.first(where: { $0.firstAttribute == .height })
	}
	
}

/// We cannot add an extension to UIViewController and allows to override the
/// default implementation in UIViewController subclasses. So be sure to
/// use StackContainable only for UIViewController until a new Swift version
/// allows these stuff.
public protocol StackContainable: class {
	
	/// You should implement it in your UIViewController subclass in order
	/// to specify how it must appear when contained in a ScrollingStackContainer.
	/// Default implementation is specified below.
	///
	/// - Returns: appearance
	func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance
	
}

extension StackContainable where Self: UIViewController {
	
	/// You must override this method if you need to specify a custom appearance of the view
	/// controller instance when contained in a ScrollingStackController.
	/// By default each view controller's view is rendered as a fixed height view.
	/// Height is calculated automatically in this order:
	/// - attempt to use optional auto-layout height constraint
	/// - attempt to use preferredContentSize value
	/// - attempt to use view's frame.height
	///
	///
	/// - Returns: Appearance of the controller when contained a ScrollingStackController
	public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
		// Search for intrinsic height constraint
		var height_constraint = self.view.heigthConstraint?.constant ?? 0
		// Attempt to use the preferredContentSize height
		if height_constraint == 0 {
			height_constraint = self.preferredContentSize.height
		}
		// Attempt to use view's height
		if height_constraint == 0 {
			height_constraint = self.view.frame.size.height
		}
		guard height_constraint > 0 else {
			print("ViewController \(self) does not specify a valid height when contained in stack")
			return .view(height: height_constraint)
		}
		return .view(height: height_constraint)
	}
}

public class ScrollingStackController: UIViewController, UIScrollViewDelegate {
	
	/// This define the behaviour stack needs to keep for a specified controller
	///
	/// - view: fixed height view. You should use it only for view which does not contains scrolling data
	/// - scroll: use it when your view controller contains an UIScrollView subclass. Specify it as paramter
	///           along with optional edge insets from the superview.
	public enum ItemAppearance {
		case view(height: CGFloat)
		case scroll(_: UIScrollView, insets: UIEdgeInsets)
	}
	
	/// This is the parent scroll view. Be sure to connect it to a valid object
	@IBOutlet public var scrollView: UIScrollView?
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		guard let scroll = self.scrollView else { // you must to create a valid scroll view
			fatalError("You must connect a valid scroll view to the view controller")
		}
		scroll.translatesAutoresizingMaskIntoConstraints = false
		scroll.delegate = self
	}
	
	/// Reference to stacked items
	private var items: [StackItem] = []
	
	/// Use this property to set the ordered list of UIViewController instances
	/// you want to set into the stack view
	public var viewControllers: [StackContainable] {
		set {
			self.removeAllViewControllers()
			self.items = newValue.map { StackItem($0 as! UIViewController, $0.preferredAppearanceInStack() ) }
			self.relayoutItems()
		}
		get { return self.items.map { $0.controller as! StackContainable } }
	}
	
	/// Adjust stacked items as the view did scroll
	///
	/// - Parameter scrollView: scrollview
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		self.adjustContentOnScroll()
	}
	
	/// This function remove all view controllers from the stack
	private func removeAllViewControllers() {
		self.items.forEach {
			$0.controller.removeFromParentViewController()
			$0.controller.view.removeFromSuperview()
		}
		self.items.removeAll()
	}
	
	/// Adjust layout as the parent view's change
	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.relayoutItems()
	}
	
	/// Return the visible portion of the scrolling stack scroll view
	private var visibleRect: CGRect {
		get {
			return CGRect(x: 0.0,
			              y: scrollView!.contentOffset.y,
			              width: scrollView!.frame.size.width,
			              height: scrollView!.frame.size.height)
		}
	}
	
	/// This function is used to calculate the rect of each item into the stack
	/// and put it in place. It's called when a new array of items is set.
	public func relayoutItems() {
		var offset_y: CGFloat = 0.0
		let width = self.scrollView!.frame.size.width
		
		for item in self.items {
			var itemHeight: CGFloat = 0.0
			
			switch item.appearance {
			case .scroll(let scrollView, let insets):
				// for UIViewController with table/collections/scrollview inside
				// the occupied space is calculated with the content size of scroll
				// itself and specified inset of it inside the parent view.
				itemHeight = scrollView.contentSize.height
				itemHeight += insets.top + insets.bottom // take care of the insets
				break
			case .view(let height):
				// for standard UIView it uses provided height
				itemHeight = height
			}
			
			// This is the ideal rect
			item.rect = CGRect(x: 0.0, y: offset_y, width: width, height: itemHeight)
			item.controller.view.frame = item.rect // don't worry, its adjusted below
			// add the view in place
			self.scrollView!.addSubview(item.controller.view)
			offset_y += itemHeight // calculate the new offset
		}
		// Setup manyally the content size and adjust the items based upon the visibility
		self.scrollView!.contentSize = CGSize(width: width, height: offset_y)
		self.adjustContentOnScroll()
	}
	
	
	/// This function is used to adjust the frame of the object as the parent
	/// scroll view did scroll.
	/// How it works:
	/// - Standard UIViewController's with `view` appearance are showed as is. No changes are
	///   applied to the frame of the view itself.
	/// - UIViewController with `scroll` appearance are managed by adjusting the specified
	///   scrollview's offset and frame in order to take care of the visibility region into the
	///   parent scroll view.
	///   When scroll reaches the top of the scrollview it's pinned on top and the offset is adjusted
	///   on scroll in order to simulate a continous scrolling of the parent scrollview.
	///   The frame of the inner scroll is adjusted in order to occupy at the max the entire region
	///   of the parent, and when partially visible, only the visible region.
	////  In this way we can maximize the memory usage by using table/collection's caching architecture.
	private func adjustContentOnScroll() {
		let scrollView = self.scrollView!
		let contentOffset = scrollView.contentOffset
		
		// This is the visible rect of the parent scroll view
		let visibleRect = self.visibleRect
		// This is the current offset into parent scroll view
		let mainOffsetY = contentOffset.y
		
		let w = scrollView.frame.size.width
		
		// Enumerate each item of the stack
		for item in self.items {
			let itemRect = item.rect // get the ideal rect (occupied space)
			switch item.appearance {
			case .view(_):
				// Standard UIView are ignored
				break
			case .scroll(let innerScroll, let insets):
				// A special consideration is made for scroll views
				innerScroll.isScrollEnabled = false // disable scrolling so it does not interfere with the parent scroll
				
				// evaluate the visible region in parent
				let itemVisibleRect = visibleRect.intersection(itemRect)
				
				if itemVisibleRect.height == 0.0 {
					// If not visible the frame of the inner's scroll is canceled
					// No cells are rendered until the item became partially visible
					innerScroll.frame = CGRect.zero
				} else {
					// The item is partially visible
					if mainOffsetY > (itemRect.minY + insets.bottom) {
						// If during scrolling the inner table/collection has reached the top
						// of the parent scrollview it will be pinned on top
						
						// This calculate the offset reached while scrolling the inner scroll
						// It's used to adjust the inner table/collection offset in order to
						// simulate continous scrolling
						let innerScrollOffsetY = mainOffsetY - itemRect.minY - insets.top
						// This is the height of the visible region of the inner table/collection
						let visibleInnerHeight = innerScroll.contentSize.height - innerScrollOffsetY
						
						var innerScrollRect = CGRect.zero
						innerScrollRect.origin = CGPoint(x: 0, y: innerScrollOffsetY + insets.top)
						if visibleInnerHeight < visibleRect.size.height {
							// partially visible when pinned on top
							innerScrollRect.size = CGSize(width: w, height: min(visibleInnerHeight,itemVisibleRect.height))
						} else {
							// the inner scroll occupy the entire parent scroll's height
							innerScrollRect.size = itemVisibleRect.size
						}
						innerScroll.frame = innerScrollRect
						// adjust the offset to simulate the scroll
						innerScroll.contentOffset = CGPoint(x: 0, y: innerScrollOffsetY)
					} else {
						// The inner scroll view is partially visible
						// Adjust the frame as it needs (at its max it reaches the height of the parent)
						let offsetOfInnerY = (itemRect.minY + insets.top) - mainOffsetY
						let visibileHeight = visibleRect.size.height - offsetOfInnerY
						
						innerScroll.frame = CGRect(x: 0, y: insets.top, width: w, height: visibileHeight)
						innerScroll.contentOffset = CGPoint.zero
					}
				}
			}
		}
	}
	
}
