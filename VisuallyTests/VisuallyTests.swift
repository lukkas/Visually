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
    private var superview: View!
    private var view1: View!
    private var view2: View!
    private var view3: View!
    private let superviewSize = CGSize(width: 100, height: 100)
    
    override func setUp() {
        super.setUp()
        superview = View(frame: CGRect(origin: .zero, size: superviewSize))
        superview.addConstraints([superview.widthAnchor.constraint(equalToConstant: superviewSize.width),
                                 superview.heightAnchor.constraint(equalToConstant: superviewSize.height)])
        view1 = View()
        view2 = View()
        view3 = View()
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
        XCTAssertEqual(constraints[2].priority, LayoutPriority(750))
    }
    
    func testMiddleConstraintConstantIsGreaterThanOrEqual100_whenSuchValueIsSet() {
        let constraints = H(|-view1->=(100)-view2-|)
        XCTAssertEqual(constraints[1].constant, 100)
        XCTAssertEqual(constraints[1].relation, .greaterThanOrEqual)
    }
    
    func testView2TakesRemainingWidth_whenPinnedToViewThatTakesArbitraryWidth() {
        layoutWith(
            H(|-view1[50]-view2-|),
            V(|-view1-|),
            V(|-view2-|)
        )
        XCTAssertEqual(view2.frame.width, 50)
    }
    
    func testView2TakesRemainingWidth_whenItHasArbitraryWidthSetButOfLowerPriorityThanView1AndSpacingConstraint() {
        layoutWith(
            H(|-view1[50]-20-view2[50~500]-|),
            V(|-view1-|),
            V(|-view2-|)
        )
        XCTAssertEqual(view2.frame.width, 30)
    }
    
    func testView2TakesRemainingWidth_whenItHasArbitraryWidthSetButOfLowerPriorityThanView1AndGreaterThanOrEqualSpacingConstraint() {
        layoutWith(
            H(|-view1[50]->=20-view2[50~500]-|),
            V(|-view1-|),
            V(|-view2-|)
        )
        XCTAssertEqual(view2.frame.width, 30)
    }
    
    func testView2TakesRemainingHeight_whenItHasArbitraryHeightSetButOfLowerPriorityThanView1AndGreaterThanOrEqualSpacingConstraint() {
        layoutWith(
            H(|-view1-|),
            H(|-view2-|),
            V(|-view1[50]->=20-view2[50~500]-|)
        )
        XCTAssertEqual(view2.frame.height, 30)
    }
    
    func testView2Takes50Points_whenItHasGreaterThanOrEqual50ConstraintSetAndView1TakesRemainingSpace() {
        layoutWith(
            H(|-view1-|),
            H(|-view2-|),
            V(|-view1[50~500]->=20-view2[>=50]-|)
        )
        XCTAssertEqual(view2.frame.height, 50)
    }
    
    func testViewWidthIs80_whenItsWidthFillsSuperviewUpButTrailingGreaterThanOrEqualConstriantPushesItIn() {
        layoutWith(
            H(|-view1[100~900]->=20-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testViewWidthIs80_whenItsWidthFillsSuperviewUpButLeadingGreaterThanOrEqualConstriantPushesItIn() {
        layoutWith(
            H(|->=20-view1[100~900]-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testViewWidthIs80_whenItsWidthIsFalfOfSuperviewUpButLeadingLessThanOrEqualConstraintStretchesItOut() {
        layoutWith(
            H(|-<=20-view1[50~900]-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsWidthIsLargerThanSuperviewButItHasTrailingGreaterThanOrEqualConstraint() {
        layoutWith(
            H(|-view1[120~900]->=-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 100)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsWidthIsLargerThanSuperviewButItHasLeadingGreaterThanOrEqualConstraint() {
        layoutWith(
            H(|->=-view1[120~LayoutPriority.defaultHigh]-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 100)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsHeightIsLargerThanSuperviewButItHasBottomGreaterThanOrEqualConstraint() {
        layoutWith(
            H(|-view1-|),
            V(|-view1[120~900]->=-|)
        )
        XCTAssertEqual(view1.frame.height, 100)
    }
    
    func testViewIsKeptWithinSuperviewBounds_whenItsHeightIsLargerThanSuperviewButItHasTopGreaterThanOrEqualConstraint() {
        layoutWith(
            H(|-view1-|),
            V(|->=-view1[120~900]-|)
        )
        XCTAssertEqual(view1.frame.height, 100)
    }
    
    func testLessThenOrEqualWidthConstraintIsRespected_whenViewHasConflictingConstraintsOfLowerPriorities() {
        layoutWith(
            H(|-view1[<=80]-(0~900)-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 80)
    }
    
    func testMarginIsAt10Points_whenViewIsPinnedWithLeadingConstraint() {
        layoutWith(
            H(|-10-view1-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.origin.x, 10)
    }
    
    func testViewsDontOverlap_whenTheyHaveGreaterThanOrEqualConstraintAndBothArePinnedLeadingAndTrailingWithLowerPriorities() {
        layoutWith(
            H(|-view1-(0~900)-|),
            H(|-(0~800)-view2-|),
            H(view1->=-view2),
            V(|-view1-|),
            V(|-view2-|)
        )
        XCTAssertEqual(view1.frame.width + view2.frame.width, 100)
    }
    
    func testViewFillsSuperviewUp_whenItHasLessThanOrEqualTopConstraintAndHeightConstraintOfLowerPriority() {
        layoutWith(
            V(|-<=-view1[80~900]-|),
            H(|-view1-|)
        )
        XCTAssertEqual(view1.frame.height, 100)
    }
    
    func testViewsAdhereEachOther_whenTheyHaveLowHeightsButLessThanOrEqualConstraintsPullsThemTogether() {
        layoutWith(
            V(|-view1[20]-<=-view2[20~900]-|),
            H(|-view1-|),
            H(|-view2-|)
        )
        XCTAssertEqual(view2.frame.height, 80)
    }
    
    func testViewsHaveSpacingDefinedByLessThanOrEqualConstrint_whenTheyHaveLowHeightsThayWouldOtherwiseRecedeThemMore() {
        layoutWith(
            V(|-view1[20]-<=10-view2[20~900]-|),
            H(|-view1-|),
            H(|-view2-|)
        )
        XCTAssertEqual(view2.frame.height, 70)
    }
    
    func testViewTouchesSuperviewTrailingEdge_whenItHasLessThanOrEqualTrailingConstraintAndConflictingConstraintsOfLowerPriorities() {
        layoutWith(
            H(|-view1[20~900]-<=-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 100)
    }
    
    func testViewHas10PointsOfSuperviewTrailingMargin_whenItHasLessThanOrEqualTrailingConstraintAndConflictingConstraintsOfLowerPriorities() {
        layoutWith(
            H(|-view1[20~900]-<=10-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.width, 90)
    }
    
    func testView2HasSameHorizontalPositionAsView1_whenCenterHorizontalConstraintIsSet() {
        layoutWith(
            H(view1[20]),
            H(view2[20]),
            centerHorizontally(view1, view2),
            V(|-view1[20]-view2-|)
        )
        XCTAssertEqual(view1.frame.minX, view2.frame.minX)
    }
    
    func testView2HasSameVerticalPositionAsView1_whenCenterVerticalConstraintIsSet() {
        layoutWith(
            H(|-view1[20]-view2-|),
            V(view1[20]),
            V(view2[20]),
            centerVertically(view1, view2)
        )
        XCTAssertEqual(view1.frame.minY, view2.frame.minY)
    }
    
    func testView1CenterXIsEqualToSuperviewCenterX_whenHorizontalCenterToSuperviewFunctionIsUsed() {
        layoutWith(
            centerHorizontallyInSuperview(view1),
            H(view1[20]),
            V(|-view1-|)
        )
        XCTAssertEqual(superview.frame.midX, view1.frame.midX)
    }
    
    func testView1CenterYIsEqualToSuperviewCenterY_whenVerticalCenterToSuperviewFunctionIsUsed() {
        layoutWith(
            H(|-view1-|),
            centerVerticallyInSuperview(view1),
            V(view1[20])
        )
        XCTAssertEqual(superview.frame.midY, view1.frame.midY)
    }
    
    func testView1CenterIsEqualToSuperviewCenter_whenCenterToSuperviewFunctionIsUsed() {
        layoutWith(
            H(view1[20]),
            V(view1[20]),
            centerInSuperview(view1)
        )
        XCTAssertEqual(superview.frame.midX, view1.frame.midX)
        XCTAssertEqual(superview.frame.midY, view1.frame.midY)
    }
    
    func testViewIsOnTheLeft_whenConstrainedToTrailingButDisregardingLayoutDirection() {
        #if os(iOS) || os(tvOS)
        superview.semanticContentAttribute = .forceLeftToRight
        #elseif os(OSX)
        superview.userInterfaceLayoutDirection = .rightToLeft
        #endif
        layoutWith(
            H(|-view1[20], options: .disregardLayoutDirection),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.minX, 0)
    }
    
    #if os(iOS) || os(tvOS)
    func testViewHasMarginOf10_whenToLayoutMarginsOptionIsUsed() {
        superview.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layoutWith(
            H(|-view1-|, options: .toLayoutMargins),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.minX, 16)
    }
    #endif
    
    func testViewsHaveSameWidth_whenThayBothHave50PercentWidth() {
        layoutWith(
            H(|-view1[50%]-view2[50%]-|),
            V(|-view1-|)
        )
        XCTAssertEqual(view1.frame.size.width, view2.frame.size.width)
    }
}

private extension VisuallyTests {
    func layoutWith(_ constraints: [NSLayoutConstraint]...) {
        let c = constraints.flatMap({ $0 })
        NSLayoutConstraint.activate(c)
        superview._layout()
    }
}

private extension View {
    func _layout() {
        #if os(iOS) || os(tvOS)
        layoutIfNeeded()
        #elseif os(OSX)
        layoutSubtreeIfNeeded()
        #endif
    }
}
