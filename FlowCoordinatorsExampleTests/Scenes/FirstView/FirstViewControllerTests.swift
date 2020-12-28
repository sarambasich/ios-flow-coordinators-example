//
//  FirstViewControllerTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class FirstViewControllerTests: XCTestCase {

    // MARK: - Properties

    private var subject: FirstViewController!

    private let testApp = MyTestApplication()

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Helpers

    private func makeFirstViewController(with flowDelegate: FirstViewModelFlowDelegate? = nil) -> FirstViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: FirstViewController.identifier, creator: { (coder) -> FirstViewController? in
            let vm = FirstViewModel(application: self.testApp, flowDelegate: flowDelegate)
            return FirstViewController(coder: coder, viewModel: vm)
        })
    }

    // MARK: - Test cases

    func testViewDidLoadSetsUpView() {
        subject = makeFirstViewController()

        subject.viewDidLoad()

        XCTAssertEqual(subject.title, "First View Controller")
    }

}
