//
//  NavAViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/8/20.
//

import UIKit


class NavCViewController: ViewController<NavCViewModel> {

    static let identifier = "NavCViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Event handlers

    @IBAction func didSelectPopToRootButton(_ sender: UIButton) {
        viewModel.selectPopToRootButton()
    }

}

// MARK: - Private

private extension NavCViewController {

    func setupView() {
        title = viewModel.title
    }

}
