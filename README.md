<p align="center" >
<img src="https://raw.githubusercontent.com/malcommac/ScrollingStackContainer/develop/logo.png" width=300px height=197px alt="ScrollingStackContainer" title="ScrollingStackContainer">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/ScrollingStackContainer.svg)](https://travis-ci.org/malcommac/ScrollingStackContainer) [![Version](https://img.shields.io/cocoapods/v/ScrollingStackContainer.svg?style=flat)](http://cocoadocs.org/docsets/ScrollingStackContainer) [![License](https://img.shields.io/cocoapods/l/ScrollingStackContainer.svg?style=flat)](http://cocoadocs.org/docsets/ScrollingStackContainer) [![Platform](https://img.shields.io/cocoapods/p/ScrollingStackContainer.svg?style=flat)](http://cocoadocs.org/docsets/ScrollingStackContainer)

<p align="center" >★★ <b>Star our github repository to help us!</b> ★★</p>
<p align="center" >Created by <a href="http://www.danielemargutti.com">Daniele Margutti</a> (<a href="http://www.twitter.com/danielemargutti">@danielemargutti</a>)</p>

`ScrollingStackContainer` is an efficient scrolling `UIStackView` replacement, more suitable in situations when you are building a scrolling container with an heterogeneous number of items.
It allows you to stack vertically `UIViewController` instances where the view is a simple fixed-height `UIView` or a `UICollectionView` or `UITableView`.

## Motivation
A full article about the motivation behind this class is available on Medium (or in my personal blog). Check it here for full details about how the class works.

UITableView and UICollectionView are great when you need to display a number of relatively simple cells; when your layout became complex you may need to create different UIViewController which manages each different kind layout.
These view controller may contains simple fixed-height `UIView` or complex `UICollectionView`/`UITableView`; in these cases you need to be careful because expading your scrollviews will destroy internal iOS caching mechanism.
`ScrollingStackContainer` allows you to stack view controllers easily without any worry; it manages view controllers with scrolling collections automatically in order to reduce the amount of memory usage.

## How to use it

It's very simple to implement: for **fixed height views** you should set a valid `height` (grater than zero). This can be done in your `UIViewController`'s subclass in one of the following ways:

* set an height constraint on `UIViewController`’s .view
* … or return a value into `preferredContentSize()` function
* … or set the height via `self.frame`
* … or by implementing the `StackContainable` protocol and returning `.view(height: <height>)` with a valid value.

For view controllers which **contains inner’s scroll views** (for example table or collections) you need to implement the `StackContainble` protocol by returning `.scroll(<inner scroll instance>, <insets of the inner scroll in superview>)`.

After that you should simply set the `viewControllers` property of your `ScrollingStackContainer` subclass:

```swift
	// view controller's view are stacked vertically in order
	self.viewControllers = [controller_2,controller_1,controller_3]
```

That’s all! All the business logic is managed by the class and you can enjoy!

See the example in this repository to get a live preview!

The following example is a vertical stack which contains a fixed height view controller, a view controller with a table inside and another fixed height controller.

![ScrollingStackContainer](https://raw.githubusercontent.com/malcommac/ScrollingStackContainer/develop/example.gif)

## You also may like

Do you like `ScrollingStackContainer`? I'm also working on several other opensource libraries.

Take a look here:

* **[Hydra](https://github.com/malcommac/Hydra)** - Promises & Await/Async in Swift - Write better async code in Swift
* **[SwiftLocation](https://github.com/malcommac/SwiftLocation)** - CoreLocation and Beacon Monitoring on steroid!
* **[SwiftRichString](https://github.com/malcommac/SwiftRichString)** - Elegant and painless attributed string in Swift
* **[SwiftScanner](https://github.com/malcommac/SwiftScanner)** - String scanner in pure Swift with full unicode support
* **[SwiftSimplify](https://github.com/malcommac/SwiftSimplify)** - Tiny high-performance Swift Polyline Simplification Library
* **[SwiftMsgPack](https://github.com/malcommac/SwiftMsgPack)** - MsgPack Encoder/Decoder in Swit

## Installation

`ScrollingStackContainer` supports multiple methods for installing the library in a project.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like `ScrollingStackContainer` in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate ScrollingStackContainer into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
use_frameworks!
pod 'ScrollingStackContainer', '~> 0.5'
end
```

Then, run the following command:

```bash
$ pod install
```

### Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate ScrollingStackContainer into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "malcommac/ScrollingStackContainer" ~> 0.5
```

Run `carthage` to build the framework and drag the built `ScrollingStackContainer.framework` into your Xcode project.

## Requirements

Current version is compatible with:

* Swift 3.1
* iOS 8 or later
* ...and virtually any platform which is compatible with Swift 3 and implements the Swift Foundation Library


## Credits & License
ScrollingStackContainer is owned and maintained by [Daniele Margutti](http://www.danielemargutti.com/) along with main contributions of [Jeroen Houtzager](https://github.com/Hout).

As open source creation any help is welcome!

The code of this library is licensed under MIT License; you can use it in commercial products without any limitation.
