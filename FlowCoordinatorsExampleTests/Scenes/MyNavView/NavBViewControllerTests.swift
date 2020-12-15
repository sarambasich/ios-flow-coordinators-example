//
//  NavAViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/15/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class NavBViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var subject: NavBViewController!

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Helpers

    private func makeNavBViewController(with flowDelegate: NavBViewModelFlowDelegate? = nil) -> NavBViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: NavBViewController.identifier, creator: { (coder) -> NavBViewController? in
            let vm = NavBViewModel(flowDelegate: flowDelegate)
            return NavBViewController(coder: coder, viewModel: vm)
        })
    }

    // MARK: - Test cases

    func testDidSelectPushCButton_callsToViewModel_callsToFlowDelegate() {
        let delegate = MockNavBViewModelFlowDelegate()
        subject = makeNavBViewController(with: delegate)
        subject.didSelectPushCButton(UIButton())

        XCTAssertTrue(delegate.didSelectPushCButtonWasCalled)
    }

}
