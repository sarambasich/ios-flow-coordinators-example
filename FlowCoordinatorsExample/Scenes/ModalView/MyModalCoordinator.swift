//
//  MyModalCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyModalCoordinator: NSObject, Coordinator {

    let associatedScenes: [Scene] = [.myModal]

    private let rootViewController: UIViewController

    private let myModalViewController: MyModalViewController

    weak var delegate: MyModalCoordinatorDelegate?

    private var childCoordinators: [Coordinator] = []

    /// Init with root vc for presentation.
    init(rootViewController: UIViewController, delegate: MyModalCoordinatorDelegate? = nil) {
        self.rootViewController = rootViewController
        self.myModalViewController = getModalViewControllerFromStoryboard()
        self.delegate = delegate
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene, scene == associatedScenes.first else {
            throw RoutingError.unsupportedRoute
        }

        myModalViewController.presentationController?.delegate = self
        rootViewController.present(myModalViewController, animated: animated, completion: nil)
    }

    func start(animated: Bool) {
        try! navigate(to: Route(scenes: [.myModal], userIntent: nil), animated: animated)
    }

    func dismiss(animated: Bool) {
        myModalViewController.dismiss(animated: animated) {
            self.delegate?.coordinatorDidFinish(self)
        }
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate

extension MyModalCoordinator: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.coordinatorDidFinish(self)
    }

}

// MARK: - Private

private func getModalViewControllerFromStoryboard() -> MyModalViewController {
    let sb = UIStoryboard(name: "Main", bundle: .main)
    return sb.instantiateViewController(identifier: MyModalViewController.identifier) { (coder) -> MyModalViewController? in
        let vm = MyModalViewModel()
        return MyModalViewController(coder: coder, viewModel: vm)
    }
}

// MARK: - Delegate

protocol MyModalCoordinatorDelegate: CoordinatorDelegate { }
