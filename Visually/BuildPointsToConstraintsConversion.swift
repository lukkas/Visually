//
//  BuildPointsToConstraintsConversion.swift
//  VisualConstraints
//
//  Created by Łukasz Kasperek on 20.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

public func H(_ buildPoint: BuildPoint, options: Options = []) -> [NSLayoutConstraint] {
    return buildPoint.constraints.map({ $0(.horizontal, options) })
}

public func V(_ buildPoint: BuildPoint, options: Options = []) -> [NSLayoutConstraint] {
    return buildPoint.constraints.map({ $0(.vertical, options) })
}

public func centerHorizontallyToEachOther(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return constrainables.pairs().reduce([NSLayoutConstraint](), { (result, pair) -> [NSLayoutConstraint] in
        return result + [pair.0.centerXAnchor.constraint(equalTo: pair.1.centerXAnchor)]
    })
}

public func centerVerticallyToEachOther(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return constrainables.pairs().reduce([NSLayoutConstraint](), { (result, pair) -> [NSLayoutConstraint] in
        return result + [pair.0.centerYAnchor.constraint(equalTo: pair.1.centerYAnchor)]
    })
}
