
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

> **NOTE:** As of iOS 9, this library is no longer necessary.
>
> You should use [`SFSafariViewController`](https://developer.apple.com/library/prerelease/ios/documentation/SafariServices/Reference/SFSafariViewController_Ref/index.html) instead.

# ⚠ Deprecated ⚠

# JSQWebViewController

[![Build Status](https://secure.travis-ci.org/jessesquires/JSQWebViewController.svg)](http://travis-ci.org/jessesquires/JSQWebViewController) [![Version Status](https://img.shields.io/cocoapods/v/JSQWebViewController.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/JSQWebViewController.svg)][mitLink] [![codecov](https://codecov.io/gh/jessesquires/JSQWebViewController/branch/develop/graph/badge.svg)](https://codecov.io/gh/jessesquires/JSQWebViewController) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Platform](https://img.shields.io/cocoapods/p/JSQWebViewController.svg)][docsLink]

*A lightweight Swift WebKit view controller for iOS*

![screenshot](https://raw.githubusercontent.com/jessesquires/JSQWebViewController/develop/Screenshots/screenshot_0.png)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![screenshot](https://raw.githubusercontent.com/jessesquires/JSQWebViewController/develop/Screenshots/screenshot_1.png)

## Requirements

* Swift 3.2+
* Xcode 9+
* iOS 8+

## Installation

#### [CocoaPods](http://cocoapods.org) (recommended)

````ruby
use_frameworks!

# For latest release in cocoapods
pod 'JSQWebViewController'
````

#### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "jessesquires/JSQWebViewController"
````

## Documentation

Read the [docs][docsLink]. Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com).

#### Generate

````bash
$ ./build_docs.sh
````

#### Preview

````bash
$ open index.html -a Safari
````

## Getting Started

````swift
import JSQWebViewController

let controller = WebViewController(url: URL(string: "http://jessesquires.com")!)
let nav = UINavigationController(rootViewController: controller)
present(nav, animated: true, completion: nil)
````

See the included example app, open `Example/Example.xcodeproj`.

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

`JSQWebViewController` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2015 Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[mitLink]:http://opensource.org/licenses/MIT
[docsLink]:http://jessesquires.github.io/JSQWebViewController
[podLink]:https://cocoapods.org/pods/JSQWebViewController
