//
//  NavAViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class NavCViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: NavCViewModel!

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSelectPopToRootButton_callsToFlowDelegate() {
        let delegate = MockNavCViewModelFlowDelegate()
        subject = NavCViewModel(flowDelegate: delegate)

        subject.selectPopToRootButton()

        XCTAssertTrue(delegate.didSelectPopToRootButtonWasCalled)
    }

}
