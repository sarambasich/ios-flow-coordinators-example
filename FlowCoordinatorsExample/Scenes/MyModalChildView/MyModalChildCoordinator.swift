//
//  MyModalChildCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/14/20.
//

import UIKit


class MyModalChildCoordinator: NSObject, Coordinator {

    static var associatedScenes: [Scene] {
        [.myModalChild]
    }

    weak var delegate: MyModalChildCoordinatorDelegate?

    // MARK: - Private properties

    private let rootViewController: UIViewController

    private let myModalChildViewController: MyModalChildViewController

    // MARK: - Initialization

    init(rootViewController: UIViewController, delegate: MyModalChildCoordinatorDelegate? = nil) {
        self.rootViewController = rootViewController
        self.myModalChildViewController = getViewControllerFromStoryboard()
        self.delegate = delegate

        super.init()

        myModalChildViewController.presentationController?.delegate = self
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene, scene == MyModalChildCoordinator.associatedScenes.first else {
            throw RoutingError.invalidScene
        }

        rootViewController.present(myModalChildViewController, animated: animated, completion: nil)
    }

    func start(animated: Bool) {
        try! navigate(to: Route(scenes: [.myModalChild], userIntent: nil), animated: animated)
    }

    func dismiss(animated: Bool) {
        myModalChildViewController.dismiss(animated: true) {
            self.delegate?.coordinatorDidFinish(self)
        }
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate

extension MyModalChildCoordinator: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.coordinatorDidFinish(self)
    }

}

// MARK: - Delegate

protocol MyModalChildCoordinatorDelegate: CoordinatorDelegate { }

// MARK: - Private

private func getViewControllerFromStoryboard() -> MyModalChildViewController {
    let sb = UIStoryboard(name: "Main", bundle: .main)
    return sb.instantiateViewController(identifier: MyModalChildViewController.identifier) { (coder) -> MyModalChildViewController? in
        let vm = MyModalChildViewModel()
        return MyModalChildViewController(coder: coder, viewModel: vm)
    }
}
