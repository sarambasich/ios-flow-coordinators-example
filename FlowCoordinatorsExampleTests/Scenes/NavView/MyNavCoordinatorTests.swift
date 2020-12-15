//
//  MyNavCoordinatorTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MyNavCoordinatorTests: XCTestCase {

    // MARK: - Properties

    private var subject: MyNavCoordinator!

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
        XCTAssertEqual(MyNavCoordinator.associatedScenes.count, 3)
        XCTAssertEqual(MyNavCoordinator.associatedScenes, [.navA, .navB, .navC])
    }

    func testNavigateWithValidScene() {
        subject = MyNavCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.navA], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: true))

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        guard navController.viewControllers.first is NavAViewController else {
            XCTFail("Did not get nav 'A' view controller")
            return
        }
    }

    func testNavigateWithMultipleValidScenes() {
        subject = MyNavCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.navA, .navB, .navC], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        XCTAssertEqual(navController.viewControllers.count, 3)

        XCTAssertTrue(navController.viewControllers[0] is NavAViewController)
        XCTAssertTrue(navController.viewControllers[1] is NavBViewController)
        XCTAssertTrue(navController.viewControllers[2] is NavCViewController)
    }

    func testNavigateWithMultipleValidScenesInOtherOrder() {
        subject = MyNavCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.navC, .navA, .navB], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        XCTAssertEqual(navController.viewControllers.count, 3)

        XCTAssertTrue(navController.viewControllers[0] is NavCViewController)
        XCTAssertTrue(navController.viewControllers[1] is NavAViewController)
        XCTAssertTrue(navController.viewControllers[2] is NavBViewController)
    }

    func testNavigateWithEmptyRouteThrowsUnsupportedError() {
        subject = MyNavCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: false)) { (error) in
            guard case RoutingError.unsupportedRoute = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testNavigateWithInvalidSceneThrowsInvalidError() {
        subject = MyNavCoordinator(rootViewController: rootViewController)

        let route = Route(scenes: [.myModal], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: false)) { (error) in
            guard case RoutingError.invalidScene = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testStartSucceeds() {
        subject = MyNavCoordinator(rootViewController: rootViewController)
        subject.start(animated: false)

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        XCTAssertEqual(navController.viewControllers.count, 1)

        XCTAssertTrue(navController.viewControllers[0] is NavAViewController)
    }

    func testDismissSucceeds() {
        let exp = expectation(description: "The view controller should dismiss and the coordinator finishes")
        let mockDelegate = MockDelegate()
        subject = MyNavCoordinator(rootViewController: rootViewController, delegate: mockDelegate)
        mockDelegate.coordinatorDidFinishCallbackBlock = { (coordinator) in
            XCTAssertTrue(coordinator === self.subject)
            XCTAssertNil(self.rootViewController.presentedViewController)

            exp.fulfill()
        }

        subject.start(animated: false)
        subject.dismiss(animated: false)

        wait(for: [exp], timeout: 1.0)
    }

    // MARK: Nav view model delegate methods

    func testDidSelectPushBButton_navigateToNavBScene() {
        subject = MyNavCoordinator(rootViewController: rootViewController)
        subject.didSelectPushBButton()

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        XCTAssertEqual(navController.viewControllers.count, 1)

        XCTAssertTrue(navController.viewControllers[0] is NavBViewController)
    }

    func testDidSelectPushCButton_navigateToNavCScene() {
        subject = MyNavCoordinator(rootViewController: rootViewController)
        subject.didSelectPushCButton()

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        XCTAssertEqual(navController.viewControllers.count, 1)

        XCTAssertTrue(navController.viewControllers[0] is NavCViewController)
    }

    func testDidSelectPopToRootButton_popsToRoot() {
        subject = MyNavCoordinator(rootViewController: rootViewController)

        try! subject.navigate(to: Route(scenes: [.navA, .navC, .navB], userIntent: nil), animated: false)

        guard let navController = rootViewController.presentedViewController as? UINavigationController else {
            XCTFail("Did not get navigation controller from root")
            return
        }

        XCTAssertEqual(navController.viewControllers.count, 3)

        XCTAssertTrue(navController.viewControllers[0] is NavAViewController)
        XCTAssertTrue(navController.viewControllers[1] is NavCViewController)
        XCTAssertTrue(navController.viewControllers[2] is NavBViewController)

        subject.didSelectPopToRootButton()

        XCTAssertEqual(navController.viewControllers.count, 1)

        XCTAssertTrue(navController.viewControllers[0] is NavAViewController)
    }

    func testPresentationControllerDidDismiss_callsCoordinatorDidFinish() {
        let exp = expectation(description: "The view controller should dismiss and the coordinator finishes")
        let mockDelegate = MockDelegate()
        subject = MyNavCoordinator(rootViewController: rootViewController, delegate: mockDelegate)
        mockDelegate.coordinatorDidFinishCallbackBlock = { (coordinator) in
            XCTAssertTrue(coordinator === self.subject)

            exp.fulfill()
        }

        subject.presentationControllerDidDismiss(UIPresentationController.init(presentedViewController: rootViewController, presenting: nil))

        wait(for: [exp], timeout: 1.0)
    }

}

// MARK: - Mock delegate

private class MockDelegate: MyNavCoordinatorDelegate {
    var coordinatorDidFinishCallbackBlock: ((Coordinator) -> Void)?

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        coordinatorDidFinishCallbackBlock?(coordinator)
    }
}
