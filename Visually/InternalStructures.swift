//
//  InternalStructures.swift
//  Visually
//
//  Created by Łukasz Kasperek on 25.07.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

typealias Constraint = (Axis, Options) -> NSLayoutConstraint

enum Axis {
    case horizontal
    case vertical
}

enum AxisAbstractedAnchor {
    case opening // left, leading, top
    case closing // right, trailing, bottom
}
