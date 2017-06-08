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

extension UIColor {
	
	static func random() -> UIColor {
  let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
  let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
  let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
		
  return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
	}
	
}

public class ContainerListCell: UITableViewCell {
	@IBOutlet public var titleLabel: UILabel?
}

public class ContainerList: UIViewController, StackContainable, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet public var tableView: UITableView?
	
	var counts: Int = 20
	var colors: [UIColor] = []
	
	public static func create() -> ContainerList {
		return UIStoryboard(name: "Containers", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContainerList") as! ContainerList
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView?.delegate = self
		self.tableView?.dataSource = self
		
		self.view.backgroundColor = UIColor.lightGray
		
		colors.removeAll()
		for _ in 0..<counts {
			colors.append(UIColor.random())
		}
		
		self.tableView?.reloadData()
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return counts
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ContainerListCell") as! ContainerListCell
		
		cell.titleLabel?.text = "Cell \(indexPath.row)"
		cell.backgroundColor = colors[indexPath.row]
		return cell
	}
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}
	
	public func preferredAppearanceInStack() -> ScrollingStackController.ItemAppearance {
		let _ = self.view // force load of the view
		return .scroll(self.tableView!, insets: UIEdgeInsetsMake(50, 0, 50, 0))
	}
}
