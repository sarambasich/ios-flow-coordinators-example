//
//  FirstViewController.swift
//  CoordinatorsTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet private var bodyLabel: UILabel?

    var viewModel: FirstViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }


}

private extension FirstViewController {

    func setupView() {
        guard let viewModel = viewModel else { return }

        title = viewModel.title
        bodyLabel?.text = viewModel.bodyText
    }

}

