//
//  FirstViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet private var bodyLabel: UILabel?

    var viewModel: FirstViewModel? {
        didSet {
            setupView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "modalSegue" where segue.destination is MyModalViewController:
            break
        case "navSegue" where segue.destination is UINavigationController:
            break
        default:
            break
        }
    }

}

// MARK: - Event handlers

private extension FirstViewController {

    @IBAction func didSelectPresentModalButton(_ sender: UIButton) {

    }

    @IBAction func didSelectPresentNavButton(_ sender: UIButton) {

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

