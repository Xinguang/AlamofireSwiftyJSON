# AlamofireSwiftyJSON

[![Build Status](https://travis-ci.org/Xinguang/AlamofireSwiftyJSON.svg)](https://travis-ci.org/Xinguang/AlamofireSwiftyJSON)
[![Swift version](https://img.shields.io/badge/swift-3.0-orange.svg)](https://developer.apple.com/swift/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/AlamofireSwiftyJSON)
[![SwiftLint](https://img.shields.io/badge/SwiftLint-passing-brightgreen.svg)](https://github.com/realm/SwiftLint)
[![codecov.io](https://codecov.io/gh/xinguang/AlamofireSwiftyJSON/branch/master/graph/badge.svg)](https://codecov.io/gh/xinguang/AlamofireSwiftyJSON?branch=master)
[![GitHub release](https://img.shields.io/github/release/xinguang/AlamofireSwiftyJSON.svg)](https://github.com/xinguang/AlamofireSwiftyJSON/releases)

---
Easy way to use both [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.1+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build AlamofireSwiftyJSON.

To integrate AlamofireSwiftyJSON into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'AlamofireSwiftyJSON'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate AlamofireSwiftyJSON into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Xinguang/AlamofireSwiftyJSON"
```

Run `carthage update` to build the framework and drag the built `AlamofireSwiftyJSON.framework` into your Xcode project.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but AlamofireSwiftyJSON does support its use on supported platforms.

Once you have your Swift package set up, adding AlamofireSwiftyJSON as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .Package(url: "https://github.com/Xinguang/AlamofireSwiftyJSON.git", majorVersion: 1)
]
```


## Usage

```swift
let URL = "http://httpbin.org/get"
Alamofire.request(URL, method: .get, parameters: ["foo": "bar"]).responseSwiftyJSON { response in
  print("###Success: \(response.result.isSuccess)")
  //now response.result.value is SwiftyJSON.JSON type
  print("###Value: \(response.result.value?["args"].array)")
}

```
