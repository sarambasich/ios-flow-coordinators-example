//
//  NavAViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import Foundation


struct NavAViewModel: ViewModel {

    let title = "Hi A"

    weak var flowDelegate: NavAViewModelFlowDelegate?

    // MARK: - Initialization

    init(flowDelegate: NavAViewModelFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
    }

    // MARK: - Methods

    /// Call this when the user selects the button to push the B scene.
    func selectPushBButton() {
        flowDelegate?.didSelectPushBButton()
    }

}

protocol NavAViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the button to push the B scene.
    func didSelectPushBButton()

}
