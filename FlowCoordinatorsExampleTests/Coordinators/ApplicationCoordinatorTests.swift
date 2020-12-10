//
//  ApplicationCoordinatorTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class ApplicationCoordinatorTests: XCTestCase {

    // MARK: - Properties

    private var subject: ApplicationCoordinator!

    private let testApp = MyTestApplication()

    private var window: UIWindow!

    // MARK: - Test setup

    override func setUp() {
        window = UIWindow()
        window.rootViewController = FirstViewController()
    }

    override func tearDown() {
        window = nil
        subject = nil
    }

    // MARK: - Test cases

    func testAssociatedScenes() {
        subject = ApplicationCoordinator(application: testApp, window: window)

        XCTAssertEqual(subject.associatedScenes.count, 1)
        XCTAssertEqual(subject.associatedScenes, [.first])
    }

    func testNavigateWithValidScene() {
        subject = ApplicationCoordinator(application: testApp, window: window)

        let route = Route(scenes: [.first], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: true))

        XCTAssertTrue(window.isKeyWindow)
        XCTAssertFalse(window.isHidden)
    }

    func testNavigateWithInvalidScene() {
        subject = ApplicationCoordinator(application: testApp, window: window)

        let route = Route(scenes: [.navA], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: true)) { (error) in
            guard case RoutingError.invalidScene = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testStartSucceeds() {
        subject = ApplicationCoordinator(application: testApp, window: window)

        subject.start(animated: true)

        XCTAssertTrue(window.isKeyWindow)
        XCTAssertFalse(window.isHidden)
    }

    // TODO: should we be testing the `navigateTo` functions? There's no way
    // to verify them right now...I don't want to add exposed properties just
    // to support a test case, but if there's a reason to expose other properties
    // (e.g. `presentedViewController`) then it makes sense to add test cases
    // for the subsequent navigation methods here.
    //
    // Same for `CoordinatorDelegate` methods.
    //
    // I think there's some iteration here that still needs to happen.

    func testNavigateToNavViewSucceeds() {
        subject = ApplicationCoordinator(application: testApp, window: window)
        subject.start(animated: false)
        subject.navigateToNavView()

        guard let firstViewController = window.rootViewController as? FirstViewController else {
            XCTFail("Couldn't get first VC")
            return
        }

        guard let navController = firstViewController.presentedViewController as? UINavigationController else {
            XCTFail("Couldn't get nav controller")
            return
        }

        XCTAssertTrue(navController.viewControllers.first is NavAViewController)
    }

    func testNavigateToModalViewSucceeds() {
        subject = ApplicationCoordinator(application: testApp, window: window)
        subject.start(animated: false)
        subject.navigateToModalView()

        guard let firstViewController = window.rootViewController as? FirstViewController else {
            XCTFail("Couldn't get first VC")
            return
        }

        XCTAssertTrue(firstViewController.presentedViewController is MyModalViewController)
    }

}
