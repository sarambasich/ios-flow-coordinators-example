//
//  FirstCoordinatorTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class FirstCoordinatorTests: XCTestCase {

    // MARK: - Properties

    private var subject: FirstCoordinator!

    private let testApp = MyTestApplication()

    private var rootViewController: UIViewController!

    // MARK: - Test setup

    override func setUp() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = UINavigationController()
        rootViewController = sceneDelegate.window!.rootViewController
    }

    override func tearDown() {
        subject = nil
        rootViewController = nil
    }

    // MARK: - Test cases

    func testAssociatedScenes() {
        XCTAssertEqual(FirstCoordinator.associatedScenes.count, 1)
        XCTAssertEqual(FirstCoordinator.associatedScenes, [.first])
    }

    func testNavigateWithValidScene() {
        subject = FirstCoordinator(application: testApp, rootViewController: rootViewController)

        let route = Route(scenes: [.first], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))

        XCTAssertTrue(rootViewController.presentedViewController is FirstViewController)
    }

    func testNavigateWithInvalidScene() {
        subject = FirstCoordinator(application: testApp, rootViewController: rootViewController)

        let route = Route(scenes: [.login], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: false)) { (error) in
            guard case RoutingError.invalidScene = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testStartSucceeds() {
        subject = FirstCoordinator(application: testApp, rootViewController: rootViewController)

        subject.start(animated: false)

        XCTAssertTrue(rootViewController.presentedViewController is FirstViewController)
    }

    func testNavigateToNavViewSucceeds() {
        subject = FirstCoordinator(application: testApp, rootViewController: rootViewController)
        subject.start(animated: false)
        do {
            try subject.navigate(to: Route(scenes: [.navA], userIntent: nil), animated: false)
        } catch let error {
            XCTFail("Could not navigate due to error: \(error)")
            return
        }

        guard let firstViewController = rootViewController.presentedViewController as? FirstViewController else {
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
        subject = FirstCoordinator(application: testApp, rootViewController: rootViewController)
        subject.start(animated: false)
        do {
            try subject.navigate(to: Route(scenes: [.myModal], userIntent: nil), animated: false)
        } catch let error {
            XCTFail("Could not navigate due to error: \(error)")
            return
        }

        guard let firstViewController = rootViewController.presentedViewController as? FirstViewController else {
            XCTFail("Couldn't get first VC")
            return
        }

        XCTAssertTrue(firstViewController.presentedViewController is MyModalViewController)
    }

}
