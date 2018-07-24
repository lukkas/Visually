//
//  Array+Helpers.swift
//  Visually
//
//  Created by Łukasz Kasperek on 22.07.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

extension Array {
    func pairs() -> [(Element, Element)] {
        var result = [(Element, Element)]()
        for (index, element) in enumerated() {
            guard index < indices.last! else { break }
            let next = self[index + 1]
            result.append((element, next))
        }
        return result
    }
}
