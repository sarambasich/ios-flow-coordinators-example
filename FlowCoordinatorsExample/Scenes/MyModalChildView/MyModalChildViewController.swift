//
//  MyModalChildViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/14/20.
//

import UIKit


class MyModalChildViewController: ViewController<MyModalChildViewModel> {

    static let identifier = "MyModalChildViewController"

    // MARK: - Event handlers

    @IBAction func didSelectTriggerDismiss(_ sender: UIButton) {
        viewModel.selectTriggerDismiss()
    }

}
