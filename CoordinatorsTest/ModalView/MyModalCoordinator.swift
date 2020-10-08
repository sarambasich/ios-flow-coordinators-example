//
//  MyModalCoordinator.swift
//  CoordinatorsTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyModalCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    let rootViewController: UIViewController

    let modalViewController: MyModalViewController

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        self.modalViewController = getModalViewControllFromStoryboard()
    }

    func start() {
        modalViewController.modalPresentationStyle = .formSheet
        rootViewController.present(modalViewController, animated: true, completion: nil)
    }

}


private func getModalViewControllFromStoryboard() -> MyModalViewController {
    let sb = UIStoryboard(name: "Main", bundle: .main)
    return sb.instantiateViewController(identifier: "MyModalCoordinator") as! MyModalViewController
}
