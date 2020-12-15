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

    func testTitle() {
        subject = FirstViewModel(application: testApp, flowDelegate: nil)

        XCTAssertEqual(subject.title, "First View Controller")
    }

    func testBodyText() {
        subject = FirstViewModel(application: testApp, flowDelegate: nil)

        XCTAssertEqual(subject.bodyText, "Hello, I am some fake body text.")
    }

    func testSelectNavButton() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavButton()

        XCTAssertTrue(delegate.didSelectNavButtonWasCalled)
    }

    func testSelectModalButton() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectModalButton()

        XCTAssertTrue(delegate.didSelectModalButtonWasCalled)
    }

    func testSelectModalChildButton() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectModalChildButton()

        XCTAssertTrue(delegate.didSelectModalChildButtonWasCalled)
    }

    func testSelectNavBButton() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavBButton()

        XCTAssertTrue(delegate.didSelectNavBButtonWasCalled)
    }

    func testSelectNavCButton() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavCButton()

        XCTAssertTrue(delegate.didSelectNavCButtonWasCalled)
    }

    func testSelectNavAButtonOutOfOrder() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavAButtonOutOfOrder()

        XCTAssertTrue(delegate.didSelectNavAButtonOutOfOrderWasCalled)
    }

    func testSelectNavCButtonOutOfOrder() {
        let delegate = MockFirstViewModelFlowDelegate()
        subject = FirstViewModel(application: testApp, flowDelegate: delegate)
        subject.selectNavCButtonOutOfOrder()

        XCTAssertTrue(delegate.didSelectNavCButtonOutOfOrderWasCalled)
    }

}
