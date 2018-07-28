//
//  Percent.swift
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

public postfix func % (integer: Int) -> Percent {
    return Percent(integer)
}

public struct Percent {
    private let _value: Int
    
    public init(_ percent: Int) {
        _value = percent
    }
    
    public var value: Int {
        return _value
    }
    
    public var decimal: CGFloat {
        return CGFloat(_value) / 100
    }
}
