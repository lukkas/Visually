//
//  ConstraintParameters.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public struct ConstraintParameters: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public let constant: CGFloat
    public let priority: UILayoutPriority
    
    public init(constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        self.constant = constant
        self.priority = priority
    }
    
    public init(integerLiteral value: Int) {
        constant = CGFloat(value)
        priority = .required
    }
    
    public init(floatLiteral value: Float) {
        constant = CGFloat(value)
        priority = .required
    }
}
