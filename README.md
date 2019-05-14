## AlignmentControl is a component for alignment

[![Twitter](https://img.shields.io/badge/twitter-@JiromTomson-blue.svg?style=flat
)](https://twitter.com/JiromTomson)
[![CI Status](https://travis-ci.org/tularovbeslan/AlignmentControl.svg?branch=master)](https://travis-ci.org/tularovbeslan/AlignmentControl)
[![Version](https://img.shields.io/cocoapods/v/AlignmentControl.svg?style=flat)](https://cocoapods.org/pods/AlignmentControl)
![iOS 10.0+](https://img.shields.io/badge/iOS-10.0%2B-red.svg)
![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg)
[![License](https://img.shields.io/cocoapods/l/AlignmentControl.svg?style=flat)](https://cocoapods.org/pods/AlignmentControl)
[![Platform](https://img.shields.io/cocoapods/p/AlignmentControl.svg?style=flat)](https://cocoapods.org/pods/AlignmentControl)

![Artboard](https://user-images.githubusercontent.com/4906243/57692047-72610b80-764e-11e9-9ff9-9ddfcd32dfda.png)

## Direction

| AlignmentDirection |  |
| --- | --- |
| **Horizontal** | <img src="https://user-images.githubusercontent.com/4906243/57696792-55cad080-765a-11e9-8977-d99aa79e5465.png" width="100"/> |
| **Vertical** | <img src="https://user-images.githubusercontent.com/4906243/57696791-55cad080-765a-11e9-87a3-06a0a41c69fb.png" width="100"/> |

## Mode

| AlignmentMode |  |
| --- | --- |
| **Left** | <img src="https://user-images.githubusercontent.com/4906243/57696992-e3a6bb80-765a-11e9-8cd4-43165598a44d.png" width="30"/> |
| **Center** | <img src="https://user-images.githubusercontent.com/4906243/57696991-e3a6bb80-765a-11e9-9548-50138dc8c571.png" width="30"/> |
| **Right** | <img src="https://user-images.githubusercontent.com/4906243/57696994-e43f5200-765a-11e9-826c-3119a900ba41.png" width="30"/> |
| **Top** | <img src="https://user-images.githubusercontent.com/4906243/57696997-e43f5200-765a-11e9-9021-795d742e8bf8.png" width="30"/> |
| **Middle** | <img src="https://user-images.githubusercontent.com/4906243/57696993-e3a6bb80-765a-11e9-9606-62c33ebe6d76.png" width="30"/> |
| **Bottom** | <img src="https://user-images.githubusercontent.com/4906243/57696990-e3a6bb80-765a-11e9-887c-fab2f2317141.png" width="30"/> |

## Animation
| AnimationType |  |
| --- | --- |
| **None** | <img src="https://user-images.githubusercontent.com/4906243/57695565-4433f980-7657-11e9-8fea-8df4d1357d46.gif" width="200"/> |
| **Fade** | <img src="https://user-images.githubusercontent.com/4906243/57695566-4433f980-7657-11e9-8805-9fdf0202b713.gif" width="200"/> |
| **Translation** | <img src="https://user-images.githubusercontent.com/4906243/57695568-44cc9000-7657-11e9-89b4-8a0dfbe50aea.gif" width="200"/> |
| **Bounce** | <img src="https://user-images.githubusercontent.com/4906243/57695567-4433f980-7657-11e9-9473-db6e6ff2177d.gif" width="200"/> |

## Use

```swift
let alignView = AlingmentView(frame: CGRect(x: 0, y: 0, width: 124, height: 50))
alignView.setBackgroundImage(UIImage(named: "group"))
alignView.delegate = self
alignView.dataSource = self
alignView.animation = .Bounce
alignView.activeAligmentModes = [.Left, .Top]
alignView.isPulse = false
```

you also need to conform to datasource and delegate like in UITableview
```
public protocol AlingmentViewDelegate: class {
	func didSelectOptionFor(_ mode: AlignmentMode)
}

public protocol AlingmentViewDataSource: class {
	func optionsForAlignment() -> [AlignmentMode]
}
```
more detail you can see in the example

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10.0+
Xcode Xcode 9.0+
Swift 5.0

## Installation

AlignmentControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AlignmentControl'
```
# Author

Beslan Tularov | <a href="url"><img src="https://user-images.githubusercontent.com/4906243/54856729-037dcb00-4d0d-11e9-9d6f-8a5b8e316ff8.png" height="15"> </a> [@JiromTomson](https://twitter.com/JiromTomson)

Mikhail Kupriyanov | <a href="url"><img src="https://user-images.githubusercontent.com/4906243/56862537-ae407380-69b4-11e9-9867-3ec2d09388a4.png" height="20"> </a> [mpkupriyanov](https://github.com/mpkupriyanov)

## License

```
MIT License

Copyright (c) 2018 Beslan Tularov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
