//
//  NavAViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class NavCViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var subject: NavCViewController!

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Helpers

    private func makeNavCViewController(with flowDelegate: NavCViewModelFlowDelegate? = nil) -> NavCViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: NavCViewController.identifier, creator: { (coder) -> NavCViewController? in
            let vm = NavCViewModel(flowDelegate: flowDelegate)
            return NavCViewController(coder: coder, viewModel: vm)
        })
    }

    // MARK: - Test cases

    func testDidSelectPopToRootButton_callsToViewModel_callsToFlowDelegate() {
        let delegate = MockNavCViewModelFlowDelegate()
        subject = makeNavCViewController(with: delegate)
        subject.didSelectPopToRootButton(UIButton())

        XCTAssertTrue(delegate.didSelectPopToRootButtonWasCalled)
    }

}
