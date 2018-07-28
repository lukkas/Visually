[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods](https://img.shields.io/cocoapods/v/Visually.svg?style=flat)](https://cocoapods.org/pods/Visually)
[![Platform](https://img.shields.io/cocoapods/p/Visually.svg?style=flat)](https://cocoapods.org/pods/Visually)
[![Build Status](https://travis-ci.org/lukkas/Visually.svg)](https://travis-ci.org/codecov/example-swift) 
[![codecov.io](https://codecov.io/gh/lukkas/Visually/branch/master/graphs/badge.svg)](https://codecov.io/gh/codecov/example-swift/branch/master)
[![License](https://img.shields.io/cocoapods/l/Visually.svg?style=flat)](https://cocoapods.org/pods/Visually)

# Visually

Visually is a lightweight library, that provides you with a set of custom operators, that are aimed to help you build layouts in a short and expressive way. 

Visually is heavily inspired by Apple's visual format, however it adds typesafety and removes a necessity of creating views and metrics dictionaries. In fact one of my objective was to make it as familiar for visual format's users, as custom operators' restrictions would allow.

## Restrictions

I wanted to keep Visually lightweight. It is supposed to make the kind of autolayout code, that iOS Developers write the most short, easy to write and super easy to read. My purpose wasn't to mimic all the functionality of Apple's autolayout frameworks, therefore there are kinds of constraints that can't be created with Visually, like relations between views' widths/heights or centering constraints. For those I tend to use Apple's anchor API, which blends with Visually quite well.

Swift's compiler and static analyzer tend to be slow when it comes to resolving long chains of operators and Visually is no exception here. That said, I strongly recommend against creating array of Visually expressions and then flatening it to array of constraints. Instead, I tend to create empty array of constraints and then adding constraints to it with Visually expressions, line after line.

## Installation

### Cocoapods

Add `pod 'Visually'` to your Podfile and run `pod install`.
For more details see [CocoaPods website](http://cocoapods.org)

### Carthage

Add `github "lukkas/Visually"` to your Cartfile, run `carthage update` and drag built frameworks to your Xcode project.
For more details see [Carthage git repository](https://github.com/Carthage/Carthage)

## Operators and rules

Visually defines 15 custom operators and adds subscripts to UIView/NSView in order to achieve its objectives. These operatrors can be divided into 5 groups:
- prefix operatos starting with `|` - create constraints to leading edge of the superview,
- postfix operatos ending with `|` - create constraints to trailing edge of the superview,
- infix operatos starting with `-` - create constraints between sibling views,
- `~` operator - placed next to constraint's constant value can change constraint's priority,
- prefix `>=` and `<=` operators - meant to be used inside subscript in order to change default `equal` relation to `greaterThanOrEqual` or `lessThanOrEqual` respectively.

As mentioned before, subscripts create width/height constraints.

Visually expressions, created with combinations of operators, views, constants and priorities, are always wrapped in on of two functions - `H(<expression>)` or `V(<expression>)`. They convert those expressions into arrays of NSLayoutConstraint objects for, respectively, horizontal and vertical axis.

## Example expressions

- `H(|-8-label->=8-|)` - leading to superview equal to 8, trailing to superview greater then or equal 8,
- `V(label-(10~Priority.defaultHigh)-button[44])` - top to label equal to 10 with priority of 800, button height equal to 44
- `V(button[>=44]->=-|)` - button height greater than or equal 44, bottom to superview greater than or equal 0
- `V(|->=8-label)` - top to superview greater than or equal 8
- `H(label->=10-view)` - view's leading anchor greater then or equal 10 to label's trailing anchor
- `H(|-view[50%]-button[50%]-)` - view and button are filling up the superview and both take 50% of width
- `H(|-view-|, options: .toSafeArea)` - view fills up superview safe area

## Example usage

```swift
import Visually

class MyView: UIView {
    let view: UIView
    let label: UILabel
    let button: UIButton

    func addConstraints() {
        var c = [NSLayoutConstraint]()
        c += H(|-view-label->=8-|)
        c += V(|-20-view-8-button[44]-20-|)
        NSLayoutConstraint.activate(c)
    }
}
```
