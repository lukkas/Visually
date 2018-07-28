//
//  RelativeConstraintsParameters.swift
//  Visually
//
//  Created by Łukasz Kasperek on 28.07.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public struct RelativeConstraintParameters {
    public let multiplier: CGFloat
    public let priority: Priority
    
    public init(multiplier: CGFloat = 1, priority: Priority = .required) {
        self.multiplier = multiplier
        self.priority = priority
    }
}
