//
//  MyTestApplicationTests.swift
//  FlowCoordinatorsExampleTests
//
//  Created by Stefan Arambasich on 12/28/20.
//

import XCTest
@testable import FlowCoordinatorsExample


class MyTestApplicationTests: XCTestCase {

    // MARK: - Properties

    private var subject: MyTestApplication!

    // MARK: - Test setup

    override func tearDown() {
        subject = nil
    }

    // MARK: - Test cases

    func testLogInTogglesIsAuthenticatedProperty() {
        subject = MyTestApplication()

        XCTAssertFalse(subject.isAuthenticated)

        subject.logIn()

        XCTAssertTrue(subject.isAuthenticated)
    }

    func testLogOutTogglesIsAuthenticatedProperty() {
        subject = MyTestApplication()

        subject.logIn()
        XCTAssertTrue(subject.isAuthenticated)

        subject.logOut()

        XCTAssertFalse(subject.isAuthenticated)
    }

}
