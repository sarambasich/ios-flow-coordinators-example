//
//  FirstViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit

class FirstViewController: UIViewController {

    var viewModel: FirstViewModel? {
        didSet {
            setupView()
        }
    }

    @IBOutlet private var bodyLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

}

// MARK: - Event handlers

private extension FirstViewController {

    @IBAction func didSelectPresentModalButton(_ sender: UIButton) {
        viewModel?.selectModalButton()
    }

    @IBAction func didSelectPresentNavButton(_ sender: UIButton) {
        viewModel?.selectNavButton()
    }

}


// MARK: - View setup

private extension FirstViewController {

    func setupView() {
        guard let viewModel = viewModel else { return }

        title = viewModel.title
        bodyLabel?.text = viewModel.bodyText
    }

}

