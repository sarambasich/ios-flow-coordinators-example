//
//  ViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import UIKit


class ViewController<ViewModel>: UIViewController {

    let viewModel: ViewModel

    required init?(coder: NSCoder, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with \(String(describing: ViewModel.self))")
    }

}
