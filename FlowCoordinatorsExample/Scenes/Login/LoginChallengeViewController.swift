//
//  LoginChallengeViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/16/20.
//

import UIKit


class LoginChallengeViewController: ViewController<LoginChallengeViewModel> {

    static let identifier = "LoginChallengeViewController"

    // MARK: - Event handlers

    @IBAction func didSelectSubmitButton(_ sender: UIButton) {
        viewModel.submitChallenge()
    }

}
