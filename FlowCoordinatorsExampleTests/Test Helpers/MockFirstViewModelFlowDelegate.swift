//
//  MockFirstViewModelFlowDelegate.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//

import Foundation
@testable import FlowCoordinatorsExample


final class MockFirstViewModelFlowDelegate: FirstViewModelFlowDelegate {

    private(set) var didSelectNavButtonWasCalled = false

    private(set) var didSelectModalButtonWasCalled = false

    private(set) var didSelectModalChildButtonWasCalled = false

    private(set) var didSelectNavBButtonWasCalled = false

    private(set) var didSelectNavCButtonWasCalled = false

    private(set) var didSelectNavAButtonOutOfOrderWasCalled = false

    private(set) var didSelectNavCButtonOutOfOrderWasCalled = false

    private(set) var didSelectLogOutWasCalled = false


    // MARK: - FirstViewModelFlowDelegate

    func didSelectNavButton() {
        didSelectNavButtonWasCalled = true
    }

    func didSelectModalButton() {
        didSelectModalButtonWasCalled = true
    }

    func didSelectModalChildButton() {
        didSelectModalChildButtonWasCalled = true
    }

    func didSelectNavBButton() {
        didSelectNavBButtonWasCalled = true
    }

    func didSelectNavCButton() {
        didSelectNavCButtonWasCalled = true
    }

    func didSelectNavAButtonOutOfOrder() {
        didSelectNavAButtonOutOfOrderWasCalled = true
    }

    func didSelectNavCButtonOutOfOrder() {
        didSelectNavCButtonOutOfOrderWasCalled = true
    }

    func didSelectLogOut() {
        didSelectLogOutWasCalled = true
    }

}
