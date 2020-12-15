//
//  MyModalChildViewController.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/14/20.
//

import UIKit


class MyModalChildViewController: ViewController<MyModalChildViewModel> {

    static let identifier = "MyModalChildViewController"

    @IBAction func didSelectTriggerDismiss(_ sender: UIButton) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.appCoordinator?.dismiss(animated: true)
    }

}
