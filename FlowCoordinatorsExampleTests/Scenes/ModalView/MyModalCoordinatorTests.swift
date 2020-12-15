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

    private var rootViewController: UIViewController!

    // MARK: - Test setup

    override func setUp() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.window?.rootViewController = FirstViewController()
        rootViewController = sceneDelegate.window!.rootViewController
    }

    override func tearDown() {
        subject = nil
    }

    // MARK: - Test cases

    func testAssociatedScenes() {
        XCTAssertEqual(MyModalCoordinator.associatedScenes.count, 1)
        XCTAssertEqual(MyModalCoordinator.associatedScenes, [.myModal])
    }

    func testNavigateWithValidScene() {
        subject = MyModalCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.myModal], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: true))

        XCTAssertTrue(rootViewController.presentedViewController is MyModalViewController)
    }

    func testNavigateWithInvalidScene() {
        subject = MyModalCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.navA], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: true)) { (error) in
            guard case RoutingError.invalidScene = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testNavigateWithMultipleScenes() {
        subject = MyModalCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.myModal, .myModalChild], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))

        // Workaround: seems like it takes some time after the presentation for the presented view controller
        // to register on iOS's side
        let exp = expectation(description: "wait for presented view controller to be set")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            XCTAssertTrue(self.rootViewController.presentedViewController?.presentedViewController is MyModalChildViewController)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func testStartSucceeds() {
        subject = MyModalCoordinator(rootViewController: rootViewController)
        subject.start(animated: true)

        XCTAssertTrue(rootViewController.presentedViewController is MyModalViewController)
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

private class MockDelegate: MyModalCoordinatorDelegate {
    var coordinatorDidFinishCallbackBlock: ((Coordinator) -> Void)?

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        coordinatorDidFinishCallbackBlock?(coordinator)
    }
}
