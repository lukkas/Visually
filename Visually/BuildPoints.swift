//
//  BuildPoints.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public struct BuildPoint {
    internal let constraints: [Constraint]
    internal let constrainable: Constrainable
}

public struct OpeningBuildPoint {
    internal let parameters: ConstraintParameters
    internal let relation: LayoutRelation
}

public struct ClosingBuildPoint {
    internal let parameters: ConstraintParameters
}

public struct IntermediaryBuildPoint {
    internal let lastBuildPoint: BuildPoint
    internal let parameters: ConstraintParameters
    internal let relation: LayoutRelation
}

public struct SizeBuildPoint {
    internal let parameters: ConstraintParameters
    internal let relation: LayoutRelation
}

public struct RelativeSizeBuildPoint {
    internal let percent: Percent
    internal let relation: LayoutRelation
}
