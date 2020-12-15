//
//  MyModalViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyModalViewController: ViewController<MyModalViewModel> {

    static let identifier = "MyModalViewController"

}

private extension MyModalViewController {

    @IBAction func didSelectGoToModalChildButton(_ sender: UIButton) {
        viewModel.selectGoToModalChildButton()
    }

}
