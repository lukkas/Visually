//
//  BuildPointsToConstraintsConversion.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public func H(_ buildPoint: BuildPoint) -> [NSLayoutConstraint] {
    return buildPoint.constraints.map({ $0(.horizontal) })
}

public func V(_ buildPoint: BuildPoint) -> [NSLayoutConstraint] {
    return buildPoint.constraints.map({ $0(.vertical) })
}
