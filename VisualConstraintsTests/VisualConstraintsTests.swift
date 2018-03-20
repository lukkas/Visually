//
//  VisualConstraintsTests.swift
//  VisualConstraintsTests
//
//  Created by Łukasz Kasperek on 17.03.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import XCTest
@testable import VisualConstraints

class VisualConstraintsTests: XCTestCase {
    private var superview: UIView!
    private var view1: UIView!
    private var view2: UIView!
    private var view3: UIView!
    
    override func setUp() {
        super.setUp()
        superview = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        view1 = UIView()
        view2 = UIView()
        view3 = UIView()
        superview.addSubview(view1)
        superview.addSubview(view2)
        superview.addSubview(view3)
    }
    
    override func tearDown() {
        view3 = nil
        view2 = nil
        view1 = nil
        superview = nil
        super.tearDown()
    }
    
    func testFourConstraintsAreAdded_whenPinningThreeViewHorizontally() {
        let constraints = H(|-view1-view2-view3-|)
        XCTAssertEqual(constraints.count, 4)
    }
    
    func testLastConstraintIsGreaterThanOrEqual_whenPinningRightmostviewWithSuchRelation() {
        let constraints = H(|-view1-view2->=-|)
        XCTAssertEqual(constraints[2].relation, .greaterThanOrEqual)
    }
    
    func testLastConstraintIsGreaterOrEqual20_whenPinningRightmostviewWithSuchParameters() {
        let constraints = H(|-view1-view2->=20-|)
        XCTAssertEqual(constraints[2].constant, 20)
        XCTAssertEqual(constraints[2].relation, .greaterThanOrEqual)
    }
    
    func testLastConstraintIsOfPriority750_whenPrioritySetWithIntegerExtension() {
        let constraints = H(|-view1-view2-20.priority(750)-|)
        XCTAssertEqual(constraints[2].priority, UILayoutPriority(750))
    }
}
