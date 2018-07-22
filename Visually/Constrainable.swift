//
//  Constrainable.swift
//  Visually
//
//  Created by Łukasz Kasperek on 22.07.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public protocol Constrainable: BuildPointConvertible {
    var superview: View? { get }
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension Constrainable {
    public func buildPoint() -> BuildPoint {
        return BuildPoint(constraints: [], contrainable: self)
    }
}

extension View: Constrainable {
    
}

extension LayoutGuide: Constrainable {
    public var superview: View? {
        return owningView
    }
}
