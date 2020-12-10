//
//  FirstViewModelTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/10/20.
//


import XCTest
@testable import FlowCoordinatorsExample

class FirstViewModelTests: XCTestCase {

    // MARK: - Properties

    private var subject: FirstViewModel!

    private let testApp = MyTestApplication()

    // MARK: - Test setup

    override func setUp() {
        subject = nil
    }

    // MARK: - Test cases

    func testSelectModalButton() {
        let delegate = MockFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectModalButton()

        XCTAssertTrue(delegate.didSelectModalButtonWasCalled)
    }

    func testSelectNavButton() {
        let delegate = MockFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavButton()

        XCTAssertTrue(delegate.didSelectNavButtonWasCalled)
    }

    func testSelectNavBButton() {
        let delegate = MockFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavBButton()

        XCTAssertTrue(delegate.didSelectNavBButtonWasCalled)
    }

    func testSelectNavCButton() {
        let delegate = MockFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavCButton()

        XCTAssertTrue(delegate.didSelectNavCButtonWasCalled)
    }

    func testSelectNavAButtonOutOfOrder() {
        let delegate = MockFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavAButtonOutOfOrder()

        XCTAssertTrue(delegate.didSelectNavAButtonOutOfOrderWasCalled)
    }

    func testSelectNavCButtonOutOfOrder() {
        let delegate = MockFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavCButtonOutOfOrder()

        XCTAssertTrue(delegate.didSelectNavCButtonOutOfOrderWasCalled)
    }

}

private extension FirstViewModelTests {

    // MARK: - Mock delegate

    class MockFlowDelegate: FirstViewModelFlowDelegate {
        private(set) var didSelectModalButtonWasCalled = false
        private(set) var didSelectNavButtonWasCalled = false
        private(set) var didSelectNavBButtonWasCalled = false
        private(set) var didSelectNavCButtonWasCalled = false
        private(set) var didSelectNavAButtonOutOfOrderWasCalled = false
        private(set) var didSelectNavCButtonOutOfOrderWasCalled = false

        func didSelectModalButton() {
            didSelectModalButtonWasCalled = true
        }

        func didSelectNavButton() {
            didSelectNavButtonWasCalled = true
        }

        func didSelectNavBButton() {
            didSelectNavBButtonWasCalled = true
        }

        func didSelectNavCButton() {
            didSelectNavCButtonWasCalled = true
        }

        func didSelectNavAButtonOutOfOrder() {
            didSelectNavAButtonOutOfOrderWasCalled = true
        }

        func didSelectNavCButtonOutOfOrder() {
            didSelectNavCButtonOutOfOrderWasCalled = true
        }
    }

}
