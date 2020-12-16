//
//  MyMyModalChildViewModel.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/14/20.
//

import Foundation


class MyModalChildViewModel: ViewModel {

    weak var flowDelegate: MyModalChildViewModelFlowDelegate?

    init(flowDelegate: MyModalChildViewModelFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
    }

    /// Call this when the user selects the trigger dismiss button.
    func selectTriggerDismiss() {
        flowDelegate?.didSelectTriggerDismiss()
    }

}


// MARK: - Flow delegate


protocol MyModalChildViewModelFlowDelegate: AnyObject {

    /// Called when the user selects the trigger dismiss button.
    func didSelectTriggerDismiss()

}
