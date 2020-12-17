//
//  MyModalChildViewModelTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/16/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MyModalChildViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: MyModalChildViewModel!

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSelectTriggerDismiss_callsToFlowDelegate() {
        let delegate = MockMyModalChildViewModelFlowDelegate()
        subject = MyModalChildViewModel(flowDelegate: delegate)
        subject.selectTriggerDismiss()

        XCTAssertTrue(delegate.didSelectTriggerDismissWasCalled)
    }

}

// MARK: - Mock delegate

private final class MockMyModalChildViewModelFlowDelegate: MyModalChildViewModelFlowDelegate {

    private(set) var didSelectTriggerDismissWasCalled = false

    func didSelectTriggerDismiss() {
        didSelectTriggerDismissWasCalled = true
    }

}
