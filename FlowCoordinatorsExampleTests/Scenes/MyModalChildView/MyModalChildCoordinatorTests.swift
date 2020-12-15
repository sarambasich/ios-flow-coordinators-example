//
//  MyModalChildCoordinatorTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MyModalChildCoordinatorTests: XCTestCase {

    // MARK: - Properties

    private var subject: MyModalChildCoordinator!

    private var rootViewController: UIViewController!

    // MARK: - Test setup

    override func setUp() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = FirstViewController()
        rootViewController = sceneDelegate.window!.rootViewController
    }

    override func tearDown() {
        rootViewController = nil
    }

    // MARK: - Test cases

    func testAssociatedScenes() {
        XCTAssertEqual(MyModalChildCoordinator.associatedScenes.count, 1)
        XCTAssertEqual(MyModalChildCoordinator.associatedScenes, [.myModalChild])
    }

    func testNavigateWithValidScene() {
        subject = MyModalChildCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.myModalChild], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: true))

        XCTAssertTrue(rootViewController.presentedViewController is MyModalChildViewController)
    }

    func testNavigateWithEmptyRouteThrowsUnsupportedError() {
        subject = MyModalChildCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: false)) { (error) in
            guard case RoutingError.unsupportedRoute = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testNavigateWithInvalidScene_throwsInvalidError() {
        subject = MyModalChildCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.navA], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: true)) { (error) in
            guard case RoutingError.invalidScene = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testStartSucceeds() {
        subject = MyModalChildCoordinator(rootViewController: rootViewController)
        subject.start(animated: true)

        XCTAssertTrue(rootViewController.presentedViewController is MyModalChildViewController)
    }

    func testDismissSucceeds() {
        let exp = expectation(description: "The view controller should dismiss and the coordinator finishes")
        let mockDelegate = MockDelegate()
        subject = MyModalChildCoordinator(rootViewController: rootViewController, delegate: mockDelegate)
        mockDelegate.coordinatorDidFinishCallbackBlock = { (coordinator) in
            XCTAssertTrue(coordinator === self.subject)
            XCTAssertNil(self.rootViewController.presentedViewController)

            exp.fulfill()
        }

        subject.start(animated: false)
        subject.dismiss(animated: false)

        wait(for: [exp], timeout: 1.0)
    }

    func testPresentationControllerDidDismiss_callsCoordinatorDidFinish() {
        let exp = expectation(description: "The view controller should dismiss and the coordinator finishes")
        let mockDelegate = MockDelegate()
        subject = MyModalChildCoordinator(rootViewController: rootViewController, delegate: mockDelegate)
        mockDelegate.coordinatorDidFinishCallbackBlock = { (coordinator) in
            XCTAssertTrue(coordinator === self.subject)

            exp.fulfill()
        }

        subject.presentationControllerDidDismiss(UIPresentationController(presentedViewController: rootViewController, presenting: nil))

        wait(for: [exp], timeout: 1.0)
    }

}

// MARK: - Mock delegate

private class MockDelegate: MyModalChildCoordinatorDelegate {
    var coordinatorDidFinishCallbackBlock: ((Coordinator) -> Void)?

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        coordinatorDidFinishCallbackBlock?(coordinator)
    }
}
