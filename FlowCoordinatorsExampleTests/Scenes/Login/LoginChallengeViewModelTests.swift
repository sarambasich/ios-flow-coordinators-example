//
//  LoginChallengeViewModelTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class LoginChallengeViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: LoginChallengeViewModel!

    private let testApp = MyTestApplication()

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSubmitChallengeCallsFlowDelegate() {
        let delegate = MockLoginChallengeViewModelFlowDelegate()
        subject = LoginChallengeViewModel(application: testApp, flowDelegate: delegate)

        subject.submitChallenge()

        XCTAssertTrue(delegate.didSelectSubmitChallengeWasCalled)
    }

}
