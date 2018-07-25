//
//  Options.swift
//  Visually
//
//  Created by Łukasz Kasperek on 22.07.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public struct Options: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let disregardLayoutDirection = Options(rawValue: 0b1)
    #if os(iOS) || os(tvOS)
    public static let toLayoutMargins = Options(rawValue: 0b10)
    public static let toReadableMargins = Options(rawValue: 0b100)
    
    @available(iOS 11, *)
    public static let toSafeArea = Options(rawValue: 0b1000)
    #endif
}
