//
//  UIView+Size.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public extension Constrainable {
    public subscript(_ value: CGFloat) -> BuildPoint {
        return self[ConstraintParameters(constant: value, priority: .required)]
    }
    
    public subscript(_ value: ConstraintParameters) -> BuildPoint {
        let sizeBuildPoint = SizeBuildPoint(parameters: value, relation: .equal)
        return self[sizeBuildPoint]
    }
    
    public subscript(_ sizeBuildPoint: SizeBuildPoint) -> BuildPoint {
        let constraint: Constraint = { axis in
            switch axis {
            case .horizontal:
                return self.sizeConstraint(for: self.widthAnchor, sizeBuildPoint: sizeBuildPoint)
            case .vertical:
                return self.sizeConstraint(for: self.heightAnchor, sizeBuildPoint: sizeBuildPoint)
            }
        }
        return BuildPoint(constraints: [constraint], contrainable: self)
    }
    
    private func sizeConstraint(for dimension: NSLayoutDimension,
                                sizeBuildPoint: SizeBuildPoint) -> NSLayoutConstraint {
        let constant = sizeBuildPoint.parameters.constant
        let constraint: NSLayoutConstraint = {
            switch sizeBuildPoint.relation {
            case .equal:
                return dimension.constraint(equalToConstant: constant)
            case .greaterThanOrEqual:
                return dimension.constraint(greaterThanOrEqualToConstant: constant)
            case .lessThanOrEqual:
                return dimension.constraint(lessThanOrEqualToConstant: constant)
            }
        }()
        constraint.priority = sizeBuildPoint.parameters.priority
        return constraint
    }
}
