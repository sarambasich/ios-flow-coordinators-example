//
//  MockNavBViewModelFlowDelegate.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MockNavBViewModelFlowDelegate: NavBViewModelFlowDelegate {

    private(set) var didSelectPushCButtonWasCalled = false

    // MARK: - MockNavBViewModelFlowDelegate

    func didSelectPushCButton() {
        didSelectPushCButtonWasCalled = true
    }

}
