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

    /// Call this when the user selects the button to navigate to a modal.
    func selectModalButton() {
        flowDelegate?.didSelectModalButton()
    }

    /// Call this when the user selects the button to navigate to another navigation controller.
    func selectNavButton() {
        flowDelegate?.didSelectNavButton()
    }

}


// MARK: - Flow Delegate

protocol FirstViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the button to navigate to a modal.
    func didSelectModalButton()

    /// Called zwhen the user selects the button to navigate to another navigation controller.
    func didSelectNavButton()

}
