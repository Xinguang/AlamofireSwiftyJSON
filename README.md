#AlamofireSwiftyJSON
[![Build Status](https://travis-ci.org/starboychina/AlamofireSwiftyJSON.svg)](https://travis-ci.org/starboychina/AlamofireSwiftyJSON)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub release](https://img.shields.io/github/release/starboychina/AlamofireSwiftyJSON.svg)](https://github.com/starboychina/AlamofireSwiftyJSON/releases)

---
Easy way to use both [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Requirements

- iOS 8.0+ / Mac OS X 10.9+
- Xcode 7.0

## Install

- CocoaPods
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target "target name" do
  pod 'AlamofireSwiftyJSON'
end

```

- Carthage

[Carthage](https://github.com/Carthage/Carthage)

```ogdl
github "starboychina/AlamofireSwiftyJSON"
```

## Usage

```swift
Alamofire.request(.GET, URL, parameters: ["foo": "bar"]).responseSwiftyJSON { response in
  print("###Success: \(response.result.isSuccess)")
  print("###Response String: \(response.result.value)")
}

```
