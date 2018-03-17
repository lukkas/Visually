//
//  OperatorDefinitions.swift
//  UIExtensions
//
//  Created by Łukasz Kasperek on 16.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import Foundation

prefix operator |-
prefix operator |->=
prefix operator |-<=
prefix operator |->=-
prefix operator |-<=-

/**
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

postfix operator -|
postfix operator ->=-|
postfix operator -<=-|
