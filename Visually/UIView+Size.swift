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
        let constraint: Constraint = { (axis, _) in
            switch axis {
            case .horizontal:
                return self.sizeConstraint(for: self.widthAnchor, sizeBuildPoint: sizeBuildPoint)
            case .vertical:
                return self.sizeConstraint(for: self.heightAnchor, sizeBuildPoint: sizeBuildPoint)
            }
        }
        return BuildPoint(constraints: [constraint], constrainable: self)
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
        constraint.priority = sizeBuildPoint.parameters.priority.layoutPriority
        return constraint
    }
    
    public subscript(_ percent: Percent) -> BuildPoint {
        return self[RelativeConstraintParameters(multiplier: percent.decimal, priority: .required)]
    }
    
    public subscript(_ value: RelativeConstraintParameters) -> BuildPoint {
        let sizeBuildPoint = RelativeSizeBuildPoint(parameters: value, relation: .equal)
        return self[sizeBuildPoint]
    }
    
    public subscript(_ sizeBuildPoint: RelativeSizeBuildPoint) -> BuildPoint {
        guard let superview = superview else {
            throwMissingSuperviewException()
        }
        let constraint: Constraint = { (axis, _) in
            switch axis {
            case .horizontal:
                return self.relativeSizeConstraint(for: self.widthAnchor,
                                                     superviewDimension: superview.widthAnchor,
                                                     relativeSizeBuildPoint: sizeBuildPoint)
            case .vertical:
                return self.relativeSizeConstraint(for: self.heightAnchor,
                                                     superviewDimension: superview.heightAnchor,
                                                     relativeSizeBuildPoint: sizeBuildPoint)
            }
        }
        return BuildPoint(constraints: [constraint], constrainable: self)
    }
    
    private func relativeSizeConstraint(for dimension: NSLayoutDimension,
                                          superviewDimension: NSLayoutDimension,
                                          relativeSizeBuildPoint: RelativeSizeBuildPoint) -> NSLayoutConstraint {
        let multiplier = relativeSizeBuildPoint.parameters.multiplier
        let constraint: NSLayoutConstraint = {
            switch relativeSizeBuildPoint.relation {
            case .equal:
                return dimension.constraint(equalTo: superviewDimension, multiplier: multiplier)
            case .greaterThanOrEqual:
                return dimension.constraint(greaterThanOrEqualTo: superviewDimension, multiplier: multiplier)
            case .lessThanOrEqual:
                return dimension.constraint(lessThanOrEqualTo: superviewDimension, multiplier: multiplier)
            }
        }()
        constraint.priority = relativeSizeBuildPoint.parameters.priority.layoutPriority
        return constraint
    }
}
