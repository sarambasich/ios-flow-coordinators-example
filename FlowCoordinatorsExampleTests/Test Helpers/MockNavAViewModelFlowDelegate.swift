//
//  MockNavAViewModelFlowDelegate.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MockNavAViewModelFlowDelegate: NavAViewModelFlowDelegate {

    private(set) var didSelectPushBButtonWasCalled = false

    // MARK: - MockNavAViewModelFlowDelegate

    func didSelectPushBButton() {
        didSelectPushBButtonWasCalled = true
    }

}
