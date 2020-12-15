//
//  NavAViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import Foundation


struct NavBViewModel: ViewModel {

    let title = "Hi B"

    weak var flowDelegate: NavBViewModelFlowDelegate?

    // MARK: - Initialization

    init(flowDelegate: NavBViewModelFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
    }

    // MARK: - Methods

    /// Call this when the user selects the button to push the C scene.
    func selectPushCButton() {
        flowDelegate?.didSelectPushCButton()
    }

}

protocol NavBViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the button to push the C scene.
    func didSelectPushCButton()

}
