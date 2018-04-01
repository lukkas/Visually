//
//  BuildPoints.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
import UIKit

internal enum Axis {
    case horizontal
    case vertical
}

typealias Constraint = (Axis) -> NSLayoutConstraint

public struct BuildPoint {
    internal let constraints: [Constraint]
    internal let view: UIView
}

public struct OpeningBuildPoint {
    internal let parameters: ConstraintParameters
    internal let relation: NSLayoutRelation
}

public struct ClosingBuildPoint {
    internal let parameters: ConstraintParameters
}

public struct IntermediaryBuildPoint {
    internal let lastBuildPoint: BuildPoint
    internal let parameters: ConstraintParameters
    internal let relation: NSLayoutRelation
}
