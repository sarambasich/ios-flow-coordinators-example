//
//  NavAViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import UIKit


class NavAViewController: ViewController<NavAViewModel> {

    static let identifier = "NavAViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Event handlers

    @IBAction func didSelectPushBButton(_ sender: UIButton) {
        viewModel.selectPushBButton()
    }

}

// MARK: - Private

private extension NavAViewController {

    func setupView() {
        title = viewModel.title
    }

}
