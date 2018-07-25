//
//  OperatorImplementations.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public prefix func |- (parameters: ConstraintParameters) -> OpeningBuildPoint {
    return OpeningBuildPoint(parameters: parameters, relation: .equal)
}

public prefix func |- (bpc: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = bpc.decomposeWithSuperview()
    let constraint = openingEdgeConstraint(for: view, in: superview)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public prefix func |->= (parameters: ConstraintParameters) -> OpeningBuildPoint {
    return OpeningBuildPoint(parameters: parameters, relation: .greaterThanOrEqual)
}

public prefix func |-<= (parameters: ConstraintParameters) -> OpeningBuildPoint {
    return OpeningBuildPoint(parameters: parameters, relation: .lessThanOrEqual)
}

public prefix func |->=- (bpc: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = bpc.decomposeWithSuperview()
    let constraint = openingEdgeConstraint(for: view, in: superview, relation: .greaterThanOrEqual)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public prefix func |-<=- (bpc: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = bpc.decomposeWithSuperview()
    let constraint = openingEdgeConstraint(for: view, in: superview, relation: .lessThanOrEqual)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public func - (lhs: BuildPointConvertible, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint = siblingsConstraint(left: lView, right: rView)
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, contrainable: rView)
}

public func - (lhs: OpeningBuildPoint, rhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = rhs.decomposeWithSuperview()
    let constraint = openingEdgeConstraint(for: view, in: superview, parameters: lhs.parameters, relation: lhs.relation)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public func - (lhs: IntermediaryBuildPoint, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.lastBuildPoint.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint = siblingsConstraint(left: lView, right: rView, parameters: lhs.parameters, relation: lhs.relation)
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, contrainable: rView)
}

public func - (lhs: BuildPointConvertible, rhs: ClosingBuildPoint) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint = closingConstraint(for: view, in: superview, parameters: rhs.parameters)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public func ->=- (lhs: BuildPointConvertible, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint = siblingsConstraint(left: lView, right: rView, relation: .greaterThanOrEqual)
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, contrainable: rView)
}

public func -<=- (lhs: BuildPointConvertible, rhs: BuildPointConvertible) -> BuildPoint {
    let (lView, lConstraints) = lhs.decompose()
    let (rView, rConstraints) = rhs.decompose()
    let constraint = siblingsConstraint(left: lView, right: rView, relation: .lessThanOrEqual)
    return BuildPoint(constraints: lConstraints + [constraint] + rConstraints, contrainable: rView)
}

public func - (lhs: BuildPointConvertible, rhs: ConstraintParameters) -> IntermediaryBuildPoint {
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: rhs, relation: .equal)
}

public func ->= (lhs: BuildPointConvertible, rhs: ConstraintParameters) -> IntermediaryBuildPoint {
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: rhs, relation: .greaterThanOrEqual)
}

public func -<= (lhs: BuildPointConvertible, rhs: ConstraintParameters) -> IntermediaryBuildPoint {
    return IntermediaryBuildPoint(lastBuildPoint: lhs.buildPoint(), parameters: rhs, relation: .lessThanOrEqual)
}

public func ->= (lhs: BuildPointConvertible, rhs: ClosingBuildPoint) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint = closingConstraint(for: view, in: superview, parameters: rhs.parameters, relation: .greaterThanOrEqual)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public func -<= (lhs: BuildPoint, rhs: ClosingBuildPoint) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint = closingConstraint(for: view, in: superview, parameters: rhs.parameters, relation: .lessThanOrEqual)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public postfix func -| (lhs: ConstraintParameters) -> ClosingBuildPoint {
    return ClosingBuildPoint(parameters: lhs)
}

public postfix func -| (lhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint = closingConstraint(for: view, in: superview)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public postfix func ->=-| (lhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint = closingConstraint(for: view, in: superview, relation: .greaterThanOrEqual)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public postfix func -<=-| (lhs: BuildPointConvertible) -> BuildPoint {
    let (superview, view, constraints) = lhs.decomposeWithSuperview()
    let constraint = closingConstraint(for: view, in: superview, relation: .lessThanOrEqual)
    return BuildPoint(constraints: constraints + [constraint], contrainable: view)
}

public prefix func >= (lhs: ConstraintParameters) -> SizeBuildPoint {
    return SizeBuildPoint(parameters: lhs, relation: .greaterThanOrEqual)
}

public prefix func <= (lhs: ConstraintParameters) -> SizeBuildPoint {
    return SizeBuildPoint(parameters: lhs, relation: .lessThanOrEqual)
}

public func ~ (lhs: CGFloat, rhs: LayoutPriority) -> ConstraintParameters {
    return ConstraintParameters(constant: lhs, priority: rhs)
}

private func openingEdgeConstraint(for constrainable: Constrainable,
                                   in superview: View,
                                   parameters: ConstraintParameters = .init(),
                                   relation: LayoutRelation = .equal) -> Constraint {
    return constraint(first: (item: { _ in return constrainable }, anchor: .opening),
                      second: (item: superviewConstrainable(superview), anchor: .opening),
                      parameters: parameters,
                      relation: relation)
}

private func siblingsConstraint(left: Constrainable,
                                right: Constrainable,
                                parameters: ConstraintParameters = .init(),
                                relation: LayoutRelation = .equal) -> Constraint {
    return constraint(first: (item: { _ in return right }, anchor: .opening),
                      second: (item: { _ in return left }, anchor: .closing),
                      parameters: parameters,
                      relation: relation)
}

private func closingConstraint(for constrainable: Constrainable,
                               in superview: View,
                               parameters: ConstraintParameters = .init(),
                               relation: LayoutRelation = .equal) -> Constraint {
    return constraint(first: (item: superviewConstrainable(superview), anchor: .closing),
                      second: (item: { _ in return constrainable }, anchor: .closing),
                      parameters: parameters,
                      relation: relation)
}

private func superviewConstrainable(_ superview: View) -> (Options) -> Constrainable {
    return { options in
        #if os(iOS) || os(tvOS)
        if #available(iOS 11, *) {
            if options.contains(.toSafeArea) {
                return superview.safeAreaLayoutGuide
            }
        }
        if options.contains(.toLayoutMargins) {
            return superview.layoutMarginsGuide
        }
        if options.contains(.toReadableMargins) {
            return superview.readableContentGuide
        }
        #endif
        return superview
    }
}

private func constraint(first: (item: (Options) -> Constrainable, anchor: AxisAbstractedAnchor),
                        second: (item: (Options) -> Constrainable, anchor: AxisAbstractedAnchor),
                        parameters: ConstraintParameters,
                        relation: LayoutRelation) -> Constraint {
    return { (axis, options) in
        let c: NSLayoutConstraint = {
            switch axis {
            case .horizontal:
                return constrainingFunction(for: relation)(first.item(options).horizontalAnchor(for: first.anchor, options: options),
                                                           second.item(options).horizontalAnchor(for: second.anchor, options: options),
                                                           parameters.constant)
            case .vertical:
                return constrainingFunction(for: relation)(first.item(options).verticalAnchor(for: first.anchor),
                                                           second.item(options).verticalAnchor(for: second.anchor),
                                                           parameters.constant)
            }
        }()
        c.priority = parameters.priority
        return c
    }
}

private extension Constrainable {
    func horizontalAnchor(for abstractedAnchor: AxisAbstractedAnchor, options: Options) -> NSLayoutXAxisAnchor {
        switch (abstractedAnchor, options.contains(.disregardLayoutDirection)) {
        case (.opening, true): return leftAnchor
        case (.opening, false): return leadingAnchor
        case (.closing, true): return rightAnchor
        case (.closing, false): return trailingAnchor
        }
    }
    
    func verticalAnchor(for abstractedAnchor: AxisAbstractedAnchor) -> NSLayoutYAxisAnchor {
        switch abstractedAnchor {
        case .opening: return topAnchor
        case .closing: return bottomAnchor
        }
    }
}

private func constrainingFunction<AnchorType>(for relation: LayoutRelation) -> (NSLayoutAnchor<AnchorType>, NSLayoutAnchor<AnchorType>, CGFloat) -> NSLayoutConstraint {
    switch relation {
    case .equal:
        return { (lAnchor, rAnchor, constant) in
            return lAnchor.constraint(equalTo: rAnchor, constant: constant)
        }
    case .lessThanOrEqual:
        return { (lAnchor, rAnchor, constant) in
            return lAnchor.constraint(lessThanOrEqualTo: rAnchor, constant: constant)
        }
    case .greaterThanOrEqual:
        return { (lAnchor, rAnchor, constant) in
            return lAnchor.constraint(greaterThanOrEqualTo: rAnchor, constant: constant)
        }
    }
}

private extension BuildPointConvertible {
    func decompose() -> (Constrainable, [Constraint]) {
        let bp = buildPoint()
        return (bp.contrainable, bp.constraints)
    }
    
    func decomposeWithSuperview() -> (View, Constrainable, [Constraint]) {
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
