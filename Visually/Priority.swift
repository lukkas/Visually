//
//  Priority.swift
//  Visually
//
//  Created by Łukasz Kasperek on 28.07.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public struct Priority: Equatable, Hashable, Comparable {
    private let rawValue: Float
    
    public static var required: Priority { return Priority(rawValue: 1000) }
    public static var defaultHigh: Priority { return Priority(rawValue: 750) }
    public static var medium: Priority { return Priority(rawValue: 500) }
    public static var defaultLow: Priority { return Priority(rawValue: 250) }
    
    private init(rawValue: Float) {
        self.rawValue = rawValue
    }
    
    /**
     * Purpose of this init
     * is to be able to use it
     * with ~ operator like
     * 10~Priority(.defaultHigh + 1),
     * because 10~(Priority.defaultHigh + 1)
     * wouldn't provide enough context for
     * Swift to resolve this expression
     */
    public init(_ priority: Priority) {
        self = priority
    }
    
    public init(_ layoutPriority: LayoutPriority) {
        self.rawValue = layoutPriority.rawValue
    }
    
    public var layoutPriority: LayoutPriority {
        return LayoutPriority(rawValue: rawValue)
    }
    
    public static func + (lhs: Priority, rhs: Float) -> Priority {
        return Priority(rawValue: min(lhs.rawValue + rhs, 1000))
    }
    
    public static func - (lhs: Priority, rhs: Float) -> Priority {
        return Priority(rawValue: max(lhs.rawValue - rhs, 0))
    }
    
    public static func < (lhs: Priority, rhs: Priority) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
