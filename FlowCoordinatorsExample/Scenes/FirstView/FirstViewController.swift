//
//  FirstViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class FirstViewController: ViewController<FirstViewModel> {

    static let identifier = "FirstViewController"

    @IBOutlet private var bodyLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - Event handlers

    @IBAction func didSelectPresentNavButton(_ sender: UIButton) {
        viewModel.selectNavButton()
    }

    @IBAction func didSelectPresentModalButton(_ sender: UIButton) {
        viewModel.selectModalButton()
    }

    @IBAction func didSelectPresentModalChildButton(_ sender: UIButton) {
        viewModel.selectModalChildButton()
    }

    @IBAction func didSelectNavBButton(_ sender: UIButton) {
        viewModel.selectNavBButton()
    }

    @IBAction func didSelectNavCButton(_ sender: UIButton) {
        viewModel.selectNavCButton()
    }

    @IBAction func didSelectNavAButtonOutOfOrder(_ sender: UIButton) {
        viewModel.selectNavAButtonOutOfOrder()
    }

    @IBAction func didSelectNavCButtonOutOfOrder(_ sender: UIButton) {
        viewModel.selectNavCButtonOutOfOrder()
    }

    @IBAction func didSelectLogOutButton(_ sender: UIButton) {
        viewModel.selectLogOut()
    }

}


// MARK: - View setup

private extension FirstViewController {

    func setupView() {
        title = viewModel.title
        bodyLabel?.text = viewModel.bodyText
    }

}

