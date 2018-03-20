//
//  ConstraintParametersConvenienceCreation.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public extension CGFloat {
    public func priority(_ priority: Float) -> ConstraintParameters {
        return ConstraintParameters(constant: self, priority: UILayoutPriority(priority))
    }
    
    public func priority(_ priority: UILayoutPriority) -> ConstraintParameters {
        return ConstraintParameters(constant: self, priority: priority)
    }
}

/// for Int literals
public extension Int {
    public func priority(_ priority: Float) -> ConstraintParameters {
        return CGFloat(self).priority(priority)
    }
    
    public func priority(_ priority: UILayoutPriority) -> ConstraintParameters {
        return CGFloat(self).priority(priority)
    }
}
