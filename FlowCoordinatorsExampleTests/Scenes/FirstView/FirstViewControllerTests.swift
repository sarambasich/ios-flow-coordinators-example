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

    // MARK: - Test cases

    func testSetViewModelSetsUpView() {
        subject = FirstViewController()

        XCTAssertNil(subject.title)

        let vm = FirstViewModel(application: testApp, flowDelegate: nil)
        subject.viewModel = vm

        XCTAssertEqual(subject.title, "First View Controller")
    }

}
