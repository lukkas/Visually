//
//  UIView+Size.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public extension UIView {
    public func equal(_ value: CGFloat) -> BuildPoint {
        return equal(ConstraintParameters(constant: value, priority: .required))
    }
    
    public func equal(_ value: ConstraintParameters) -> BuildPoint {
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
    
    public func greaterThanOrEqual(_ value: CGFloat) -> BuildPoint {
        return equal(ConstraintParameters(constant: value, priority: .required))
    }
    
    public func greaterThanOrEqual(_ value: ConstraintParameters) -> BuildPoint {
        let constraint: Constraint = { axis in
            let c: NSLayoutConstraint = {
                switch axis {
                case .horizontal: return self.widthAnchor.constraint(greaterThanOrEqualToConstant: value.constant)
                case .vertical: return self.heightAnchor.constraint(greaterThanOrEqualToConstant: value.constant)
                }
            }()
            c.priority = value.priority
            return c
        }
        return BuildPoint(constraints: [constraint], view: self)
    }
    
    public func lessThanOrEqual(_ value: CGFloat) -> BuildPoint {
        return equal(ConstraintParameters(constant: value, priority: .required))
    }
    
    public func lessThanOrEqual(_ value: ConstraintParameters) -> BuildPoint {
        let constraint: Constraint = { axis in
            let c: NSLayoutConstraint = {
                switch axis {
                case .horizontal: return self.widthAnchor.constraint(lessThanOrEqualToConstant: value.constant)
                case .vertical: return self.heightAnchor.constraint(lessThanOrEqualToConstant: value.constant)
                }
            }()
            c.priority = value.priority
            return c
        }
        return BuildPoint(constraints: [constraint], view: self)
    }
}
