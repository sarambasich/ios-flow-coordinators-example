//
//  MyModalCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyModalCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    let rootViewController: UIViewController

    let modalViewController: MyModalViewController

    /// Whether or not we transitioned here using a storyboard segue
    private let isSegue: Bool

    /// Init with root vc for presentation.
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        self.modalViewController = getModalViewControllFromStoryboard()
        self.isSegue = false
    }

    /// Init with root vc and existing MyModal VC already presented - for storyboard segues only.
    init(rootViewController: UIViewController, fromSegueModalController modalViewController: MyModalViewController) {
        self.rootViewController = rootViewController
        self.modalViewController = modalViewController
        self.isSegue = true
    }

    func start() {
        guard isSegue == false else {
            print("Only call this when you are NOT using storyboard segue tranistions")
            return
        }

        modalViewController.modalPresentationStyle = .formSheet
        rootViewController.present(modalViewController, animated: true, completion: nil)
    }

}


private func getModalViewControllFromStoryboard() -> MyModalViewController {
    let sb = UIStoryboard(name: "Main", bundle: .main)
    return sb.instantiateViewController(identifier: "MyModalCoordinator") as! MyModalViewController
}
