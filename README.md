<p align="center" >
<img src="https://raw.githubusercontent.com/malcommac/ScrollingStackContainer/develop/logo.png" width=300px height=197px alt="ScrollingStackContainer" title="ScrollingStackContainer">
</p>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CI Status](https://travis-ci.org/malcommac/ScrollingStackContainer.svg)](https://travis-ci.org/malcommac/ScrollingStackContainer) [![Version](https://img.shields.io/cocoapods/v/ScrollingStackContainer.svg?style=flat)](http://cocoadocs.org/docsets/ScrollingStackContainer) [![License](https://img.shields.io/cocoapods/l/ScrollingStackContainer.svg?style=flat)](http://cocoadocs.org/docsets/ScrollingStackContainer) [![Platform](https://img.shields.io/cocoapods/p/ScrollingStackContainer.svg?style=flat)](http://cocoadocs.org/docsets/ScrollingStackContainer)

<p align="center" >★★ <b>Star our github repository to help us!</b> ★★</p>
<p align="center" >Created by <a href="http://www.danielemargutti.com">Daniele Margutti</a> (<a href="http://www.twitter.com/danielemargutti">@danielemargutti</a>)</p>

ScrollingStackContainer is an efficient scrolling UIStackView replacement, more suitable in situations when you are building a scrolling container with an heterogeneous number of items.
It allows you to stack vertically `UIViewController` instances where the view is a simple fixed-height `UIView` or a `UICollectionView` or `UITableView`.

## Motivation

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

ScrollingStackContainer supports multiple methods for installing the library in a project.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like ScrollingStackContainer in your projects. You can install it with the following command:

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
* macOS 10.10 or later
* watchOS 2.0 or later
* tvOS 9.0 or later
* ...and virtually any platform which is compatible with Swift 3 and implements the Swift Foundation Library


## Credits & License
ScrollingStackContainer is owned and maintained by [Daniele Margutti](http://www.danielemargutti.com/) along with main contributions of [Jeroen Houtzager](https://github.com/Hout).

As open source creation any help is welcome!

The code of this library is licensed under MIT License; you can use it in commercial products without any limitation.
