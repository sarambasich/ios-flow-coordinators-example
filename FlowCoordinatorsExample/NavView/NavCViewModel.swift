//
//  NavAViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import Foundation


struct NavCViewModel: ViewModel {

    let title = "Hi C"

    weak var flowDelegate: NavCViewModelFlowDelegate?

    // MARK: - Initialization

    init(flowDelegate: NavCViewModelFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
    }

    // MARK: - Methods

    /// Call this when the user selects the button to pop to the root scene.
    func selectPopToRootButton() {
        flowDelegate?.didSelectPopToRootButton()
    }

}

protocol NavCViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the button to pop to the root scene.
    func didSelectPopToRootButton()

}
