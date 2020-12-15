//
//  NavAViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class NavBViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: NavBViewModel!

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSelectPushCButton_callsToFlowDelegate() {
        let delegate = MockNavBViewModelFlowDelegate()
        subject = NavBViewModel(flowDelegate: delegate)

        subject.selectPushCButton()

        XCTAssertTrue(delegate.didSelectPushCButtonWasCalled)
    }

}
