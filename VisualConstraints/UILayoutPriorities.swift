//
//  UILayoutPriorities.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 15.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

public extension UILayoutPriority {
    /**
     * lower than default hugging priority.
     * Places with this priority are where
     * the view should stretch when there is too much space
     */
    public static var stretchPoint: UILayoutPriority {
        return UILayoutPriority(200)
    }
    
    /**
     * almost required, but breakable
     * for purposes like in stack view
     * where view can be hidden
     * and then its constraints need to collapse
     */
    public var breakableRequired: UILayoutPriority {
        return UILayoutPriority(999)
    }
}
