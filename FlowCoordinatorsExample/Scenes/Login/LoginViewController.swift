//
//  LoginViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/16/20.
//

import UIKit


class LoginViewController: UIViewController {

    static let identifier = "LoginViewController"

    var viewModel: LoginViewModel? {
        didSet {
            print("*** Set login view model")
        }
    }

    // MARK: - Event handlers

    @IBAction func didSelectLogIn(_ sender: UIButton) {
        viewModel?.logIn()
    }

}
