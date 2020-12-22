//
//  LoginViewControllerTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class LoginViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var subject: LoginViewController!

    private let testApp = MyTestApplication()

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Test cases

    func testDidselectLogIn_callsToViewModel_callsToFlowDelegate() {
        let delegate = MockLoginViewModelFlowDelegate()
        subject = LoginViewController()
        subject.viewModel = LoginViewModel(application: testApp, flowDelegate: delegate)

        subject.didSelectLogIn(UIButton())

        XCTAssertTrue(delegate.didLogInWasCalled)
    }
}

// MARK: - Mocks

private final class MockLoginViewModelFlowDelegate: LoginViewModelFlowDelegate {

    private(set) var didLogInWasCalled = false

    func didLogIn() {
        didLogInWasCalled = true
    }

}
