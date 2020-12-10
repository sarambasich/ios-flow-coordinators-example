//
//  MyModalCoordinatorTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MyModalCoordinatorTests: XCTestCase {

    // MARK: - Properties

    private var subject: MyModalCoordinator!

    private var rootViewController: UIViewController {
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        return sceneDelegate.window!.rootViewController!
    }

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Test cases

    func testAssociatedScenes() {
        subject = MyModalCoordinator(rootViewController: rootViewController)

        XCTAssertEqual(subject.associatedScenes.count, 1)
        XCTAssertEqual(subject.associatedScenes, [.myModal])
    }

    func testNavigateWithValidScene() {
        subject = MyModalCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.myModal], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: true))

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Couldn't find navigation controller")
            return
        }

        XCTAssertTrue(navController.viewControllers.first is MyModalViewController)
    }

    func testNavigateWithInvalidScene() {
        subject = MyModalCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.navA], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: true)) { (error) in
            guard case RoutingError.unsupportedRoute = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testStartSucceeds() {
        subject = MyModalCoordinator(rootViewController: rootViewController)
        subject.start(animated: true)

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Couldn't find navigation controller")
            return
        }

        XCTAssertTrue(navController.viewControllers.first is MyModalViewController)
    }

    func testDismissSucceeds() {
        let exp = expectation(description: "The view controller should dismiss and the coordinator finishes")
        let mockDelegate = MockDelegate()
        subject = MyModalCoordinator(rootViewController: rootViewController, delegate: mockDelegate)
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
        subject = MyModalCoordinator(rootViewController: rootViewController, delegate: mockDelegate)
        mockDelegate.coordinatorDidFinishCallbackBlock = { (coordinator) in
            XCTAssertTrue(coordinator === self.subject)

            exp.fulfill()
        }

        subject.presentationControllerDidDismiss(UIPresentationController.init(presentedViewController: rootViewController, presenting: nil))

        wait(for: [exp], timeout: 1.0)
    }

}

// MARK: - Mock delegate

class MockDelegate: MyModalCoordinatorDelegate {
    var coordinatorDidFinishCallbackBlock: ((Coordinator) -> Void)?

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        coordinatorDidFinishCallbackBlock?(coordinator)
    }
}
