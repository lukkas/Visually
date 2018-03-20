//
//  UIView+Size.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public extension UIView {
    public func length(_ value: CGFloat, relation: NSLayoutRelation = .equal, priority: Float) -> BuildPoint {
        return length(value, relation: relation, priority: UILayoutPriority(priority))
    }
    
    public func length(_ value: CGFloat, relation: NSLayoutRelation = .equal, priority: UILayoutPriority = .required) -> BuildPoint {
        let constraint: Constraint = { axis in
            let c: NSLayoutConstraint = {
                switch (axis, relation) {
                case (.horizontal, .equal): return self.widthAnchor.constraint(equalToConstant: value)
                case (.horizontal, .greaterThanOrEqual): return self.widthAnchor.constraint(greaterThanOrEqualToConstant: value)
                case (.horizontal, .lessThanOrEqual): return self.widthAnchor.constraint(lessThanOrEqualToConstant: value)
                case (.vertical, .equal): return self.heightAnchor.constraint(equalToConstant: value)
                case (.vertical, .greaterThanOrEqual): return self.heightAnchor.constraint(greaterThanOrEqualToConstant: value)
                case (.vertical, .lessThanOrEqual): return self.heightAnchor.constraint(lessThanOrEqualToConstant: value)
                }
            }()
            c.priority = priority
            return c
        }
        return BuildPoint(constraints: [constraint], view: self)
    }
}
