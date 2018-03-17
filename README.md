# VisualConstraints

## Example usage

```swift
import VisualConstraints

class MyView: UIView {
    let view: UIView
    let label: UILabel
    let button: UIButton

    func addConstraints() {
        let horizontalConstraints = H(|-view-label->=8-|)
        let verticalConstraints = V(|-20-view-8-button.length(44)-20-|)
        NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints)
    }
}
```
