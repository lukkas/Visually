//
//  BuildPointConvertible.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
import UIKit

public protocol BuildPointConvertible {
    func buildPoint() -> BuildPoint
}

extension BuildPoint: BuildPointConvertible {
    public func buildPoint() -> BuildPoint {
        return self
    }
}

extension UIView: BuildPointConvertible {
    public func buildPoint() -> BuildPoint {
        return BuildPoint(constraints: [], view: self)
    }
}
