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
