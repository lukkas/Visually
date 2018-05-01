//
//  OperatorDefinitions.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

/**
* Leading superview edge
* constraint operators.
*/
prefix operator |-
prefix operator |->=
prefix operator |-<=
prefix operator |->=-
prefix operator |-<=-

/**
* Siblings constraint operators.
* Use addition precedence in order
* to equalize it with "-" operator,
* which is widely used in defining
* constraints, but already defined
* in standard library with such precedence.
*/
infix operator ->=- : AdditionPrecedence
infix operator -<=- : AdditionPrecedence
infix operator ->= : AdditionPrecedence
infix operator -<= : AdditionPrecedence

/**
 * Trailing superview edge
 * constraint operators.
 */
postfix operator -|
postfix operator ->=-|
postfix operator -<=-|

/**
 * Width/height operators
 */
prefix operator >=
prefix operator <=

/**
 * Priority operator
 */
precedencegroup ConstraintPriorityPrecedence {
    higherThan: AdditionPrecedence
}

infix operator ~ : ConstraintPriorityPrecedence
