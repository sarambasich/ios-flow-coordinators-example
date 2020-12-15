//
//  NavAViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class NavAViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: NavAViewModel!

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSelectPushBButton_callsToFlowDelegate() {
        let delegate = MockNavAViewModelFlowDelegate()
        subject = NavAViewModel(flowDelegate: delegate)

        subject.selectPushBButton()

        XCTAssertTrue(delegate.didSelectPushBButtonWasCalled)
    }

}
