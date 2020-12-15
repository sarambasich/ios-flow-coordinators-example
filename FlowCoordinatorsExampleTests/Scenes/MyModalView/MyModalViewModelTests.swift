//
//  MyModalViewModelTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MyModalViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: MyModalViewModel!

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSelectGoToModalChildButton_callsDelegate() {
        let delegate = MockMyModalViewModelFlowDelegate()
        subject = MyModalViewModel(flowDelegate: delegate)
        subject.selectGoToModalChildButton()

        XCTAssertTrue(delegate.didSelectGoToModalChildButtonWasCalled)
    }

}

// MARK: - Delegate

private class MockMyModalViewModelFlowDelegate: MyModalViewModelFlowDelegate {

    private(set) var didSelectGoToModalChildButtonWasCalled = false

    func didSelectGoToModalChildButton() {
        didSelectGoToModalChildButtonWasCalled = true
    }
}
