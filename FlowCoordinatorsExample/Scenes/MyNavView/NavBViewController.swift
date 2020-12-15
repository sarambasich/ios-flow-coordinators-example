//
//  NavAViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import UIKit


class NavBViewController: ViewController<NavBViewModel> {

    static let identifier = "NavBViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Event handlers

    @IBAction func didSelectPushCButton(_ sender: UIButton) {
        viewModel.selectPushCButton()
    }

}

// MARK: - Private

private extension NavBViewController {

    func setupView() {
        title = viewModel.title
    }

}
