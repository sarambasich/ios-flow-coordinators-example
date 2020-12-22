//
//  FirstViewModel.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import Foundation


class FirstViewModel {

    /// The title for the view
    let title = "First View Controller"

    /// The body text for the view
    let bodyText = "Hello, I am some fake body text."

    // MARK: - Private properties

    /// Application object used for data management and communication.
    private let application: MyTestApplication

    /// Flow delegate to control navigation for this scene.
    weak var flowDelegate: FirstViewModelFlowDelegate?

    // MARK: - Initialization

    init(application: MyTestApplication, flowDelegate: FirstViewModelFlowDelegate? = nil) {
        self.application = application
        self.flowDelegate = flowDelegate
    }

    // MARK: - Methods

    /// Call this when the user selects the button to navigate to another navigation controller.
    func selectNavButton() {
        flowDelegate?.didSelectNavButton()
    }

    /// Call this when the user selects the button to navigate to a modal.
    func selectModalButton() {
        flowDelegate?.didSelectModalButton()
    }

    /// Call this when the user selects the button to navigate to a modal child.
    func selectModalChildButton() {
        flowDelegate?.didSelectModalChildButton()
    }

    /// Call this when the user selects the button to navigate to the B scene in the nav flow.
    func selectNavBButton() {
        flowDelegate?.didSelectNavBButton()
    }

    /// Call this when the user selects the button to navigate to the C scene in the nav flow.
    func selectNavCButton() {
        flowDelegate?.didSelectNavCButton()
    }

    /// Call this when the user selects the button to navigate to the A scene in the nav flow, in reverse order.
    func selectNavAButtonOutOfOrder() {
        flowDelegate?.didSelectNavAButtonOutOfOrder()
    }

    /// Call this when the user selects the button to navigate to the C scene in the nav flow, in reverse order.
    func selectNavCButtonOutOfOrder() {
        flowDelegate?.didSelectNavCButtonOutOfOrder()
    }

    /// Call this when the user selects the log out button.
    func selectLogOut() {
        flowDelegate?.didSelectLogOut()
    }

}


// MARK: - Flow Delegate

protocol FirstViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the button to navigate to another navigation controller.
    func didSelectNavButton()

    /// Called when the user selects the button to navigate to a modal.
    func didSelectModalButton()

    /// Called when the user selects the button to navigate to a modal child.
    func didSelectModalChildButton()

    /// Called when the user selects the button to navigate to the B scene in the nav flow.
    func didSelectNavBButton()

    /// Called when the user selects the button to navigate to the C scene in the nav flow.
    func didSelectNavCButton()

    /// Called when the user selects the button to navigate to the A scene in the nav flow, in out of order with B first.
    func didSelectNavAButtonOutOfOrder()

    /// Called when the user selects the button to navigate to the C scene in the nav flow, out of order.
    func didSelectNavCButtonOutOfOrder()

    /// Called when the user selects the log out button.
    func didSelectLogOut()

}
