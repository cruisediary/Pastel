# Pastel
🎨 Gradient animation effect like Instagram

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![CI Status](http://img.shields.io/travis/cruisediary/Pastel.svg?style=flat)](https://travis-ci.org/cruisediary/Pastel)
[![Version](https://img.shields.io/cocoapods/v/Pastel.svg?style=flat)](http://cocoapods.org/pods/Pastel)
[![License](https://img.shields.io/cocoapods/l/Pastel.svg?style=flat)](http://cocoapods.org/pods/Pastel)
[![Platform](https://img.shields.io/cocoapods/p/Pastel.svg?style=flat)](http://cocoapods.org/pods/Pastel)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

![pastel_01.gif](README/Pastel_01.gif)
![pastel_02.gif](README/Pastel_02.gif)
![pastel_03.gif](README/Pastel_03.gif)

## Example
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    let pastelView = PastelView(frame: view.bounds)

    // Custom Direction
    pastelView.startPastelPoint = .bottomLeft
    pastelView.endPastelPoint = .topRight

    // Custom Duration
    pastelView.animationDuration = 3.0

    // Custom Color
    pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                          UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                          UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                          UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                          UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                          UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                          UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])

    pastelView.startAnimation()
    view.insertSubview(pastelView, at: 0)
}
```

## 🎨 Customize Gradient Colors
#### Designed by Alexander Zaytsev, https://dribbble.com/anwaltzzz
![Gradient.png](README/Gradient.png)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Pastel is written in Swift 4. iOS 8.0+ Required

## Installation

Pastel is available through [CocoaPods](http://cocoapods.org) or [Carthage](https://github.com/Carthage/Carthage).

### Cocoapods
```ruby
pod "Pastel"
```

### Carthage
```
github "cruisediary/Pastel" ~> 0.5.0
```

## Example
- [Passcode](https://github.com/cruisediary/Passcode): A simple Passcode application using RxSwift, ReactorKit, IGListKit with Pastel

## Author

cruz, cruzdiary@gmail.com

## License

Pastel is available under the MIT license. See the LICENSE file for more info.
