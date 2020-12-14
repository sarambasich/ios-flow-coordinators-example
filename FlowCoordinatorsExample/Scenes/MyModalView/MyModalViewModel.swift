//
//  MyModalViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import Foundation


class MyModalViewModel: ViewModel {

    weak var flowDelegate: MyModalViewModelFlowDelegate?

    // MARK: - Initialization

    init(flowDelegate: MyModalViewModelFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
    }

    /// Call thiswhen the user selects the button to go to the modal child view.
    func selectGoToModalChildButton() {
        flowDelegate?.didSelectGoToModalChildButton()
    }

}


// MARK: - Flow Delegate

protocol MyModalViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the button to go to the modal child view.
    func didSelectGoToModalChildButton()

}
