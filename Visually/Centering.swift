//
//  Centering.swift
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

public func centerHorizontallyToEachOther(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return centerHorizontallyToEachOther(constrainables)
}

public func centerVerticallyToEachOther(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return centerVerticallyToEachOther(constrainables)
}

public func centerInSuperview(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return centerInSuperview(constrainables)
}

public func centerHorizontallyInSuperview(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return centerHorizontallyInSuperview(constrainables)
}

public func centerVerticallyInSuperview(_ constrainables: Constrainable...) -> [NSLayoutConstraint] {
    return centerVerticallyInSuperview(constrainables)
}

public func centerInSuperview(_ constrainables: [Constrainable]) -> [NSLayoutConstraint] {
    return constrainables.reduce(into: [NSLayoutConstraint](), { (result, constrainable) in
        guard let superview = constrainable.superview else {
            throwMissingSuperviewException()
        }
        result.append(superview.centerXAnchor.constraint(equalTo: constrainable.centerXAnchor))
        result.append(superview.centerYAnchor.constraint(equalTo: constrainable.centerYAnchor))
    })
}

public func centerHorizontallyInSuperview(_ constrainables: [Constrainable]) -> [NSLayoutConstraint] {
    return constrainables.reduce(into: [NSLayoutConstraint](), { (result, constrainable) in
        guard let superview = constrainable.superview else {
            throwMissingSuperviewException()
        }
        result.append(superview.centerXAnchor.constraint(equalTo: constrainable.centerXAnchor))
    })
}

public func centerVerticallyInSuperview(_ constrainables: [Constrainable]) -> [NSLayoutConstraint] {
    return constrainables.reduce(into: [NSLayoutConstraint](), { (result, constrainable) in
        guard let superview = constrainable.superview else {
            throwMissingSuperviewException()
        }
        result.append(superview.centerYAnchor.constraint(equalTo: constrainable.centerYAnchor))
    })
}

public func centerHorizontallyToEachOther(_ constrainables: [Constrainable]) -> [NSLayoutConstraint] {
    return constrainables.pairs().reduce(into: [NSLayoutConstraint](), { (result, pair) in
        result.append(
            pair.0.centerXAnchor.constraint(equalTo: pair.1.centerXAnchor)
        )
    })
}

public func centerVerticallyToEachOther(_ constrainables: [Constrainable]) -> [NSLayoutConstraint] {
    return constrainables.pairs().reduce(into: [NSLayoutConstraint](), { (result, pair) in
        result.append(
            pair.0.centerYAnchor.constraint(equalTo: pair.1.centerYAnchor)
        )
    })
}
