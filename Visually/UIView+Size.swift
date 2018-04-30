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

public extension View {
    public subscript(_ value: CGFloat) -> BuildPoint {
        return self[ConstraintParameters(constant: value, priority: .required)]
    }
    
    public subscript(_ value: ConstraintParameters) -> BuildPoint {
        let constraint: Constraint = { axis in
            let c: NSLayoutConstraint = {
                switch axis {
                case .horizontal: return self.widthAnchor.constraint(equalToConstant: value.constant)
                case .vertical: return self.heightAnchor.constraint(equalToConstant: value.constant)
                }
            }()
            c.priority = value.priority
            return c
        }
        return BuildPoint(constraints: [constraint], view: self)
    }
    
    public subscript(_ sizeBuildPoint: SizeBuildPoint) -> BuildPoint {
        let constant = sizeBuildPoint.parameters.constant
        let constraint: Constraint = { axis in
            let c: NSLayoutConstraint = {
                switch axis {
                case .horizontal:
                    switch sizeBuildPoint.relation {
                    case .equal:
                        return self.widthAnchor.constraint(equalToConstant: constant)
                    case .greaterThanOrEqual:
                        return self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
                    case .lessThanOrEqual:
                        return self.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
                    }
                case .vertical:
                switch sizeBuildPoint.relation {
                case .equal:
                    return self.heightAnchor.constraint(equalToConstant: constant)
                case .greaterThanOrEqual:
                    return self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
                case .lessThanOrEqual:
                    return self.heightAnchor.constraint(lessThanOrEqualToConstant: constant)
                    }
                }
            }()
            c.priority = sizeBuildPoint.parameters.priority
            return c
        }
        return BuildPoint(constraints: [constraint], view: self)
    }
}
