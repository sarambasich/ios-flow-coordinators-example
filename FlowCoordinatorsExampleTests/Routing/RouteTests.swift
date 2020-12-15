//
//  RouteTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class RouteTests: XCTestCase {

    // MARK: - Properties

    private var subject: Route!

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Test cases

    func testRemainingRoutesReturnsRemainingRoutesWhenMultiple() {
        subject = Route(scenes: [.navA, .navB], userIntent: nil)

        guard let remaining = subject.remainingRoute() else {
            XCTFail("remainingRoute was unexpectedly nil")
            return
        }

        XCTAssertNil(remaining.userIntent)
        XCTAssertEqual(remaining.scenes.count, 1)
        XCTAssertEqual(remaining.firstScene, .navB)
        XCTAssertEqual(remaining.scenes, [.navB])
    }

    func testRemainingRoutesReturnsNilWhenOnlyOne() {
        subject = Route(scenes: [.navA], userIntent: nil)

        XCTAssertNil(subject.remainingRoute())
    }

}
