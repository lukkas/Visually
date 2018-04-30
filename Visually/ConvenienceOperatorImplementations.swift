//
//  ConvenienceOperatorImplementations.swift
//  Visually
//
//  Created by Łukasz Kasperek on 30.04.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public prefix func |- (constant: CGFloat) -> OpeningBuildPoint {
    return |-ConstraintParameters(constant: constant)
}

public prefix func |->= (constant: CGFloat) -> OpeningBuildPoint {
    return |->=ConstraintParameters(constant: constant)
}

public prefix func |-<= (constant: CGFloat) -> OpeningBuildPoint {
    return |-<=ConstraintParameters(constant: constant)
}

public func - (lhs: BuildPointConvertible, rhs: CGFloat) -> IntermediaryBuildPoint {
    return lhs-ConstraintParameters(constant: rhs, priority: .required)
}

public func ->= (lhs: BuildPointConvertible, rhs: CGFloat) -> IntermediaryBuildPoint {
    return lhs->=ConstraintParameters(constant: rhs, priority: .required)
}

public func -<= (lhs: BuildPointConvertible, rhs: CGFloat) -> IntermediaryBuildPoint {
    return lhs-<=ConstraintParameters(constant: rhs, priority: .required)
}

public postfix func -| (lhs: CGFloat) -> ClosingBuildPoint {
    return ConstraintParameters(constant: lhs, priority: .required)-|
}

public prefix func >= (lhs: CGFloat) -> SizeBuildPoint {
    return >=ConstraintParameters(constant: lhs, priority: .required)
}

public prefix func <= (lhs: CGFloat) -> SizeBuildPoint {
    return <=ConstraintParameters(constant: lhs, priority: .required)
}

public func ~ (lhs: CGFloat, rhs: Float) -> ConstraintParameters {
    return lhs~LayoutPriority(rhs)
}
