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

    @IBAction func didSelectNavBButton(_ sender: UIButton) {
        viewModel?.selectNavBButton()
    }

    @IBAction func didSelectNavCButton(_ sender: UIButton) {
        viewModel?.selectNavCButton()
    }

    @IBAction func didSelectNavAButtonOutOfOrder(_ sender: UIButton) {
        viewModel?.selectNavAButtonOutOfOrder()
    }

    @IBAction func didSelectNavCButtonOutOfOrder(_ sender: UIButton) {
        viewModel?.selectNavCButtonOutOfOrder()
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

