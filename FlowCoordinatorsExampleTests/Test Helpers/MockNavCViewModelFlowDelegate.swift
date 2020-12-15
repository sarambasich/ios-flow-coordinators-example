//
//  MockNavCViewModelFlowDelegate.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MockNavCViewModelFlowDelegate: NavCViewModelFlowDelegate {

    private(set) var didSelectPopToRootButtonWasCalled = false

    // MARK: - NavCViewModelFlowDelegate

    func didSelectPopToRootButton() {
        didSelectPopToRootButtonWasCalled = true
    }

}
