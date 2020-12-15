//
//  NavAViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class NavAViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var subject: NavAViewController!

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Helpers

    private func makeNavAViewController(with flowDelegate: NavAViewModelFlowDelegate? = nil) -> NavAViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: NavAViewController.identifier, creator: { (coder) -> NavAViewController? in
            let vm = NavAViewModel(flowDelegate: flowDelegate)
            return NavAViewController(coder: coder, viewModel: vm)
        })
    }

    // MARK: - Test cases

    func testDidSelectPushBButton_callsToViewModel_callsToFlowDelegate() {
        let delegate = MockNavAViewModelFlowDelegate()
        subject = makeNavAViewController(with: delegate)
        subject.didSelectPushBButton(UIButton())

        XCTAssertTrue(delegate.didSelectPushBButtonWasCalled)
    }

}
