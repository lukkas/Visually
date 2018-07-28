//
//  ConstraintParameters.swift
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

public struct ConstraintParameters {
    public let constant: CGFloat
    public let priority: Priority
    
    public init(constant: CGFloat = 0, priority: Priority = .required) {
        self.constant = constant
        self.priority = priority
    }
}
