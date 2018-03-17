//
//  OperatorImplementations.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import UIKit

public prefix func |- (constant: CGFloat) -> OpeningBuildPoint {
    let parameters = ConstraintParameters(constant: constant)
    return OpeningBuildPoint(parameters: parameters, relation: .equal)
}

public prefix func |- (parameters: (CGFloat, UILayoutPriority)) -> OpeningBuildPoint {
    let parameters = ConstraintParameters(constant: parameters.0, priority: parameters.1)
    return OpeningBuildPoint(parameters: parameters, relation: .equal)
}

public prefix func |- (bpc: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = bpc.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return superview.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        case .vertical: return superview.topAnchor.constraint(equalTo: view.topAnchor)
        }
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public prefix func |->= (constant: CGFloat) -> OpeningBuildPoint {
    let parameters = ConstraintParameters(constant: constant)
    return OpeningBuildPoint(parameters: parameters, relation: .greaterThanOrEqual)
}

public prefix func |->= (parameters: (CGFloat, UILayoutPriority)) -> OpeningBuildPoint {
    let parameters = ConstraintParameters(constant: parameters.0, priority: parameters.1)
    return OpeningBuildPoint(parameters: parameters, relation: .greaterThanOrEqual)
}

public prefix func |-<= (constant: CGFloat) -> OpeningBuildPoint {
    let parameters = ConstraintParameters(constant: constant)
    return OpeningBuildPoint(parameters: parameters, relation: .lessThanOrEqual)
}

public prefix func |-<= (parameters: (CGFloat, UILayoutPriority)) -> OpeningBuildPoint {
    let parameters = ConstraintParameters(constant: parameters.0, priority: parameters.1)
    return OpeningBuildPoint(parameters: parameters, relation: .lessThanOrEqual)
}

public prefix func |->=- (bpc: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = bpc.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return superview.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor)
        case .vertical: return superview.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor)
        }
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public prefix func |-<=- (bpc: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = bpc.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return superview.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor)
        case .vertical: return superview.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor)
        }
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public func - (lhs: BuildPointConvertible, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return lView.trailingAnchor.constraint(equalTo: rView.leadingAnchor)
        case .vertical: return lView.bottomAnchor.constraint(equalTo: rView.topAnchor)
        }
    }
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, view: rView)
}

public func - (lhs: OpeningBuildPoint, rhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = rhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        let c: NSLayoutConstraint = {
            switch (axis, lhs.relation) {
            case (.horizontal, .equal): return superview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lhs.parameters.constant)
            case (.horizontal, .greaterThanOrEqual): return superview.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: lhs.parameters.constant)
            case (.horizontal, .lessThanOrEqual): return superview.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: lhs.parameters.constant)
            case (.vertical, .equal): return superview.topAnchor.constraint(equalTo: view.topAnchor, constant: lhs.parameters.constant)
            case (.vertical, .greaterThanOrEqual): return superview.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: lhs.parameters.constant)
            case (.vertical, .lessThanOrEqual): return superview.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: lhs.parameters.constant)
            }
        }()
        c.priority = lhs.parameters.priority
        return c
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public func - (lhs: IntermediaryBuildPoint, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.lastBuildPoint.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint: Constraint = { axis in
        let c: NSLayoutConstraint = {
            switch (axis, lhs.relation) {
            case (.horizontal, .equal): return lView.trailingAnchor.constraint(equalTo: rView.leadingAnchor, constant: lhs.parameters.constant)
            case (.horizontal, .greaterThanOrEqual): return lView.trailingAnchor.constraint(greaterThanOrEqualTo: rView.leadingAnchor, constant: lhs.parameters.constant)
            case (.horizontal, .lessThanOrEqual): return lView.trailingAnchor.constraint(lessThanOrEqualTo: rView.leadingAnchor, constant: lhs.parameters.constant)
            case (.vertical, .equal): return lView.bottomAnchor.constraint(equalTo: rView.topAnchor, constant: lhs.parameters.constant)
            case (.vertical, .greaterThanOrEqual): return lView.bottomAnchor.constraint(greaterThanOrEqualTo: rView.topAnchor, constant: lhs.parameters.constant)
            case (.vertical, .lessThanOrEqual): return lView.bottomAnchor.constraint(lessThanOrEqualTo: rView.topAnchor, constant: lhs.parameters.constant)
            }
        }()
        c.priority = lhs.parameters.priority
        return c
    }
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, view: rView)
}

public func - (lhs: BuildPointConvertible, rhs: ClosingBuildPoint) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        let c: NSLayoutConstraint = {
            switch axis {
            case .horizontal: return view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: rhs.parameters.constant)
            case .vertical: return view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: rhs.parameters.constant)
            }
        }()
        c.priority = rhs.parameters.priority
        return c
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public func ->=- (lhs: BuildPointConvertible, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return lView.trailingAnchor.constraint(greaterThanOrEqualTo: rView.leadingAnchor)
        case .vertical: return lView.bottomAnchor.constraint(greaterThanOrEqualTo: rView.topAnchor)
        }
    }
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, view: rView)
}

public func -<=- (lhs: BuildPointConvertible, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return lView.trailingAnchor.constraint(lessThanOrEqualTo: rView.leadingAnchor)
        case .vertical: return lView.bottomAnchor.constraint(lessThanOrEqualTo: rView.topAnchor)
        }
    }
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, view: rView)
}

public func ->= (lhs: BuildPointConvertible, rhs: CGFloat) -> IntermediaryBuildPoint {
    let parameters = ConstraintParameters(constant: rhs, priority: .required)
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: parameters, relation: .greaterThanOrEqual)
}

public func ->= (lhs: BuildPointConvertible, rhs: (CGFloat, UILayoutPriority)) -> IntermediaryBuildPoint {
    let parameters = ConstraintParameters(constant: rhs.0, priority: rhs.1)
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: parameters, relation: .greaterThanOrEqual)
}

public func -<= (lhs: BuildPointConvertible, rhs: CGFloat) -> IntermediaryBuildPoint {
    let parameters = ConstraintParameters(constant: rhs, priority: .required)
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: parameters, relation: .lessThanOrEqual)
}

public func -<= (lhs: BuildPointConvertible, rhs: (CGFloat, UILayoutPriority)) -> IntermediaryBuildPoint {
    let parameters = ConstraintParameters(constant: rhs.0, priority: rhs.1)
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: parameters, relation: .lessThanOrEqual)
}

public func ->= (lhs: BuildPointConvertible, rhs: ClosingBuildPoint) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        let c: NSLayoutConstraint = {
            switch axis {
            case .horizontal: return view.trailingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor, constant: rhs.parameters.constant)
            case .vertical: return view.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor, constant: rhs.parameters.constant)
            }
        }()
        c.priority = rhs.parameters.priority
        return c
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public func -<= (lhs: BuildPoint, rhs: ClosingBuildPoint) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        let c: NSLayoutConstraint = {
            switch axis {
            case .horizontal: return view.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: rhs.parameters.constant)
            case .vertical: return view.bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor, constant: rhs.parameters.constant)
            }
        }()
        c.priority = rhs.parameters.priority
        return c
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public postfix func -| (lhs: CGFloat) -> ClosingBuildPoint {
    let parameters = ConstraintParameters(constant: lhs, priority: .required)
    return ClosingBuildPoint(parameters: parameters)
}

public postfix func -| (lhs: (CGFloat, UILayoutPriority)) -> ClosingBuildPoint {
    let parameters = ConstraintParameters(constant: lhs.0, priority: lhs.1)
    return ClosingBuildPoint(parameters: parameters)
}

public postfix func -| (lhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        case .vertical: return view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        }
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

postfix func ->=-| (lhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return view.trailingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor)
        case .vertical: return view.bottomAnchor.constraint(greaterThanOrEqualTo: superview.bottomAnchor)
        }
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

postfix func -<=-| (lhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint: Constraint = { axis in
        switch axis {
        case .horizontal: return view.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor)
        case .vertical: return view.bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor)
        }
    }
    return BuildPoint(constraints: constraints + [constraint], view: view)
}

public func H(_ buildPoint: BuildPoint) -> [NSLayoutConstraint] {
    return buildPoint.constraints.map({ $0(.horizontal) })
}

public func V(_ buildPoint: BuildPoint) -> [NSLayoutConstraint] {
    return buildPoint.constraints.map({ $0(.vertical) })
}

public extension UIView {
    func length(_ value: CGFloat, relation: NSLayoutRelation = .equal, priority: UILayoutPriority = .required) -> BuildPoint {
        let constraint: Constraint = { axis in
            let c: NSLayoutConstraint = {
                switch (axis, relation) {
                case (.horizontal, .equal): return self.widthAnchor.constraint(equalToConstant: value)
                case (.horizontal, .greaterThanOrEqual): return self.widthAnchor.constraint(greaterThanOrEqualToConstant: value)
                case (.horizontal, .lessThanOrEqual): return self.widthAnchor.constraint(lessThanOrEqualToConstant: value)
                case (.vertical, .equal): return self.heightAnchor.constraint(equalToConstant: value)
                case (.vertical, .greaterThanOrEqual): return self.heightAnchor.constraint(greaterThanOrEqualToConstant: value)
                case (.vertical, .lessThanOrEqual): return self.heightAnchor.constraint(lessThanOrEqualToConstant: value)
                }
            }()
            c.priority = priority
            return c
        }
        return BuildPoint(constraints: [constraint], view: self)
    }
}

private extension BuildPointConvertible {
    func decompose() -> (UIView, [Constraint]) {
        let bp = buildPoint()
        return (bp.view, bp.constraints)
    }
    
    func decomposeWithSuperview() -> (UIView, UIView, [Constraint]) {
        let (view, constraints) = decompose()
        guard let superview = view.superview else {
            throwMissingSuperviewException()
        }
        return (superview, view, constraints)
    }
}

private func throwMissingSuperviewException() -> Never {
    fatalError("Attempt to pin view to superview, while it doesn't have one.")
}

internal extension UIView {
    func isSuperview(of other: UIView) -> Bool {
        return other.superview === self
    }
}
