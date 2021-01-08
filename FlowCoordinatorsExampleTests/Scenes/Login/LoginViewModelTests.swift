//
//  LoginViewModelTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class LoginViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: LoginViewModel!

    private let testApp = MyTestApplication()

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testLogInCallsFlowDelegate() {
        let delegate = MockLoginViewModelFlowDelegate()
        subject = LoginViewModel(application: testApp, flowDelegate: delegate)

        subject.logIn()

        XCTAssertTrue(delegate.didLogInWasCalled)
    }
}
