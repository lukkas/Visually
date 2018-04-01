//
//  VisuallyTests.swift
//  VisuallyTests
//
//  Created by Łukasz Kasperek on 01.04.2018.
//  Copyright © 2018 AppUnite. All rights reserved.
//

import XCTest
@testable import Visually

class VisuallyTests: XCTestCase {
    private var superview: UIView!
    private var view1: UIView!
    private var view2: UIView!
    private var view3: UIView!
    private let superviewSize = CGSize(width: 100, height: 100)
    
    override func setUp() {
        super.setUp()
        superview = UIView(frame: CGRect(origin: .zero, size: superviewSize))
        view1 = UIView()
        view2 = UIView()
        view3 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        view3.translatesAutoresizingMaskIntoConstraints = false
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
    
    func testTrailingConstraintIsGreaterOrEqual20_whenPinningRightmostviewWithSuchParameters() {
        let constraints = H(|-view1-view2->=20-|)
        XCTAssertEqual(constraints[2].constant, 20)
        XCTAssertEqual(constraints[2].relation, .greaterThanOrEqual)
    }
    
    func testLastConstraintIsOfPriority750_whenPrioritySetWithIntegerExtension() {
        let constraints = H(|-view1-view2-(20~750)-|)
        XCTAssertEqual(constraints[2].priority, UILayoutPriority(750))
    }
    
    func testMiddleConstraintConstantIsGreaterThanOrEqual100_whenSuchValueIsSet() {
        let constraints = H(|-view1->=(100)-view2-|)
        XCTAssertEqual(constraints[1].constant, 100)
        XCTAssertEqual(constraints[1].relation, .greaterThanOrEqual)
    }
    
    func testView2TakesRemainingWidth_whenPinnedToViewThatTakesArbitraryWidth() {
        let constraints = [
            H(|-view1.equal(50)-view2-|),
            V(|-view1-|),
            V(|-view2-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view2.frame.width, 50)
    }
    
    func testView2TakesRemainingWidth_whenItHasArbitraryWidthSetButOfLowerPriorityThanView1AndSpacingConstraint() {
        let constraints = [
            H(|-view1.equal(50)-20-view2.equal(50~500)-|),
            V(|-view1-|),
            V(|-view2-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view2.frame.width, 30)
    }
    
    func testView2TakesRemainingWidth_whenItHasArbitraryWidthSetButOfLowerPriorityThanView1AndGreaterThanOrEqualSpacingConstraint() {
        let constraints = [
            H(|-view1.equal(50)->=20-view2.equal(50~500)-|),
            V(|-view1-|),
            V(|-view2-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view2.frame.width, 30)
    }
    
    func testView2TakesRemainingHeight_whenItHasArbitraryHeightSetButOfLowerPriorityThanView1AndGreaterThanOrEqualSpacingConstraint() {
        let constraints = [
            H(|-view1-|),
            H(|-view2-|),
            V(|-view1.equal(50)->=20-view2.equal(50~500)-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view2.frame.height, 30)
    }
    
    func testView2Takes50Points_whenItHasGreaterThanOrEqual50ConstraintSetAndView1TakesRemainingSpace() {
        let constraints = [
            H(|-view1-|),
            H(|-view2-|),
            V(|-view1.equal(50~500)->=20-view2.greaterThanOrEqual(50)-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view2.frame.height, 50)
    }
    
    func testViewWidthIs80_whenItsWidthFillsSuperviewUpButTrailingGreaterThanOrEqualConstriantPushesItIn() {
        let constraints = [
            H(|-view1.equal(100~900)->=20-|),
            V(|-view1-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testViewWidthIs80_whenItsWidthFillsSuperviewUpButLeadingGreaterThanOrEqualConstriantPushesItIn() {
        let constraints = [
            H(|->=20-view1.equal(100~900)-|),
            V(|-view1-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testViewWidthIs80_whenItsWidthIsFalfOfSuperviewUpButLeadingLessThanOrEqualConstraintStretchesItOut() {
        let constraints = [
            H(|-<=20-view1.equal(50~900)-|),
            V(|-view1-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsWidthIsLargerThanSuperviewButItHasTrailingGreaterThanOrEqualConstraint() {
        let constraints = [
            H(|-view1.equal(120~900)->=-|),
            V(|-view1-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 100)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsWidthIsLargerThanSuperviewButItHasLeadingGreaterThanOrEqualConstraint() {
        let constraints = [
            H(|->=-view1.equal(120~900)-|),
            V(|-view1-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 100)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsHeightIsLargerThanSuperviewButItHasBottomGreaterThanOrEqualConstraint() {
        let constraints = [
            H(|-view1-|),
            V(|-view1.equal(120~900)->=-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 100)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsHeightIsLargerThanSuperviewButItHasTopGreaterThanOrEqualConstraint() {
        let constraints = [
            H(|-view1-|),
            V(|->=-view1.equal(120~900)-|)
            ].flatMap({ $0 })
        NSLayoutConstraint.activate(constraints)
        superview.layoutIfNeeded()
        XCTAssertEqual(view1.frame.width, 100)
    }
}
