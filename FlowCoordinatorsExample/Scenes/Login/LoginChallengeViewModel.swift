//
//  LoginChallengeViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/21/20.
//

import Foundation


final class LoginChallengeViewModel: ViewModel {

    // MARK: - Properties

    private let application: MyTestApplication

    weak var flowDelegate: LoginChallengeViewModelFlowDelegate?

    // MARK: - Initialization

    init(application: MyTestApplication, flowDelegate: LoginChallengeViewModelFlowDelegate? = nil) {
        self.application = application
        self.flowDelegate = flowDelegate
    }

    // MARK: - Methods

    /// Call this when the user submits their challenge answer.
    func submitChallenge() {
        application.logIn()
        flowDelegate?.didSelectSubmitChallenge()
    }

 }

// MARK: - Flow delegate

protocol LoginChallengeViewModelFlowDelegate: AnyObject {

    /// Called when the user submits their challenge answer.
    func didSelectSubmitChallenge()

}
