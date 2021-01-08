//
//  LoginChallengeViewControllerTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import XCTest
@testable import FlowCoordinatorsExample

class LoginChallengeViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var subject: LoginChallengeViewController!

    private let testApp = MyTestApplication()

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Helpers

    private func makeLoginChallengeViewController(with flowDelegate: LoginChallengeViewModelFlowDelegate? = nil) -> LoginChallengeViewController {
        let sb = UIStoryboard(name: "Login", bundle: .main)
        return sb.instantiateViewController(identifier: LoginChallengeViewController.identifier, creator: { (coder) -> LoginChallengeViewController? in
            let vm = LoginChallengeViewModel(application: self.testApp, flowDelegate: flowDelegate)
            return LoginChallengeViewController(coder: coder, viewModel: vm)
        })
    }

    // MARK: - Test cases

    func testDidSelectSubmitButton_callsToViewModel_callsToFlowDelegate() {
        let delegate = MockLoginChallengeViewModelFlowDelegate()
        subject = makeLoginChallengeViewController(with: delegate)

        subject.didSelectSubmitButton(UIButton())

        XCTAssertTrue(delegate.didSelectSubmitChallengeWasCalled)
    }
}
