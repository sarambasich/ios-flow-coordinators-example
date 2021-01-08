//
//  LoginViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/21/20.
//

import Foundation


final class LoginViewModel: ViewModel {

    // MARK: - Properties

    private let application: MyTestApplication

    weak var flowDelegate: LoginViewModelFlowDelegate?

    // MARK: - Initialization

    init(application: MyTestApplication, flowDelegate: LoginViewModelFlowDelegate? = nil) {
        self.application = application
        self.flowDelegate = flowDelegate
    }

    // MARK: - Methods

    /// Call this when the user successfully logs in.
    func logIn() {
        flowDelegate?.didLogIn()
    }

}

// MARK: - Flow Delegate

protocol LoginViewModelFlowDelegate: AnyObject {

    /// Called when the user successfully logs in.
    func didLogIn()

}
