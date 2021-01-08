//
//  LoginCoordinatorTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class LoginCoordinatorTests: XCTestCase {

    // MARK: - Properties

    private var subject: LoginCoordinator!

    private let testApp = MyTestApplication()

    private var window: UIWindow!

    // MARK: - Test setup

    override func setUp() {
        window = UIWindow()
        let loginVC = LoginViewController()
        window.rootViewController = UINavigationController(rootViewController: loginVC)
    }

    override func tearDown() {
        subject = nil
    }

    // MARK: - Test cases

    func testAssociatedScenes() {
        XCTAssertEqual(LoginCoordinator.associatedScenes.count, 2)
        XCTAssertEqual(LoginCoordinator.associatedScenes, [.login, .loginChallenge])
    }

    func testHasValidInitialScene() {
        subject = LoginCoordinator(application: testApp, window: window)

        let route = Route(scenes: [.login], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))
        XCTAssertTrue(subject.rootViewController.viewControllers.first is LoginViewController)

        XCTAssertTrue(window.isKeyWindow)
        XCTAssertFalse(window.isHidden)
    }

    func testNavigateWithValidScene() {
        subject = LoginCoordinator(application: testApp, window: window)

        let route = Route(scenes: [.loginChallenge], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))

        XCTAssertEqual(subject.rootViewController.viewControllers.count, 2)
        XCTAssertTrue(subject.rootViewController.viewControllers.last is LoginChallengeViewController)
    }

    func testNavigateWithInvalidScene() {
        subject = LoginCoordinator(application: testApp, window: window)

        let route = Route(scenes: [.navA], userIntent: nil)
        XCTAssertThrowsError(try subject.navigate(to: route, animated: true)) { (error) in
            guard case RoutingError.invalidScene = error else {
                XCTFail("Unexpected error thrown: \(error)")
                return
            }
        }
    }

    func testStartSucceeds() {
        subject = LoginCoordinator(application: testApp, window: window)

        subject.start(animated: true)

        XCTAssertTrue(window.isKeyWindow)
        XCTAssertFalse(window.isHidden)
    }

    func testDismissPopsToRoot() {
        subject = LoginCoordinator(application: testApp, window: window)

        let route = Route(scenes: [.login, .loginChallenge], userIntent: nil)
        XCTAssertNoThrow(try subject.navigate(to: route, animated: false))

        XCTAssertEqual(subject.rootViewController.viewControllers.count, 2)
        XCTAssertTrue(subject.rootViewController.viewControllers.last is LoginChallengeViewController)

        subject.dismiss(animated: false)

        XCTAssertEqual(subject.rootViewController.viewControllers.count, 1)
        XCTAssertTrue(subject.rootViewController.viewControllers.first is LoginViewController)
    }

    func testDidLogInNavigatesToChallenge() {
        subject = LoginCoordinator(application: testApp, window: window)

        subject.didLogIn()
        let exp = expectation(description: "challenge VC is pushed onto nav controller stack")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            XCTAssertEqual(self.subject.rootViewController.viewControllers.count, 2)
            XCTAssertTrue(self.subject.rootViewController.viewControllers.last is LoginChallengeViewController)
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    func testDidSelectSubmitChallenge_callsDelegate() {
        let delegate = MockLoginCoordinatorDelegate()
        delegate.coordinatorDidFinishWasCalled = { (coordinator) in
            XCTAssertTrue(coordinator === self.subject)
        }

        subject = LoginCoordinator(application: testApp, window: window, delegate: delegate)

        subject.didSelectSubmitChallenge()
    }

}

// MARK: - MockLoginCoordinatorDelegate

private final class MockLoginCoordinatorDelegate: LoginCoordinatorDelegate {

    var coordinatorDidFinishWasCalled: ((Coordinator) -> Void)?

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        coordinatorDidFinishWasCalled?(coordinator)
    }

}
