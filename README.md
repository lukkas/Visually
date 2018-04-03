[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods](https://img.shields.io/cocoapods/v/Visually.svg?style=flat)](https://cocoapods.org/pods/Visually)
[![Platform](https://img.shields.io/cocoapods/p/Visually.svg?style=flat)](https://cocoapods.org/pods/Visually)
[![License](https://img.shields.io/cocoapods/l/Visually.svg?style=flat)](https://cocoapods.org/pods/Visually)

# Visually

## Example usage

```swift
import Visually

class MyView: UIView {
    let view: UIView
    let label: UILabel
    let button: UIButton

    func addConstraints() {
        let horizontalConstraints = H(|-view-label->=8-|)
        let verticalConstraints = V(|-20-view-8-button.equal(44)-20-|)
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
    }
}
```
