//
//  PlatformCompatibility.swift
//  Visually
//
//  Created by Łukasz Kasperek on 02.04.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

#if os(iOS) || os(tvOS)
public typealias View = UIView
public typealias LayoutRelation = NSLayoutRelation
public typealias LayoutPriority = UILayoutPriority
public typealias LayoutGuide = UILayoutGuide
#elseif os(OSX)
public typealias View = NSView
public typealias LayoutRelation = NSLayoutConstraint.Relation
public typealias LayoutPriority = NSLayoutConstraint.Priority
public typealias LayoutGuide = NSLayoutGuide
#endif
