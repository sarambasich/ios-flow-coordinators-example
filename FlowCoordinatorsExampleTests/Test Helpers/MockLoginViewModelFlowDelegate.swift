//
//  MockLoginViewModelFlowDelegate.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/22/20.
//

import Foundation
@testable import FlowCoordinatorsExample


final class MockLoginViewModelFlowDelegate: LoginViewModelFlowDelegate {

    private(set) var didLogInWasCalled = false

    func didLogIn() {
        didLogInWasCalled = true
    }

}
