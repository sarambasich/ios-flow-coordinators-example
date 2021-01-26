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

    // MARK: Route2 Tests

    func testRoute2_instantiate() {
        let instances: [SceneInstance<SceneDependencyType>] = [
            SceneInstance(
                scene: .navA,
                dependencies: NavADependencies(text: "hi", intValue: 42)
            ),
            SceneInstance(
                scene: .navB,
                dependencies: NavBDependencies(floatValue: 1337.9)
            )
        ]
        let r2 = Route2(scenes: instances, userIntent: nil)
    }

}
