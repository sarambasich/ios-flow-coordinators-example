//
//  MockLoginChallengeViewModelFlowDelegate.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import Foundation
@testable import FlowCoordinatorsExample


final class MockLoginChallengeViewModelFlowDelegate: LoginChallengeViewModelFlowDelegate {

    private(set) var didSelectSubmitChallengeWasCalled = false

    func didSelectSubmitChallenge() {
        didSelectSubmitChallengeWasCalled = true
    }

}
