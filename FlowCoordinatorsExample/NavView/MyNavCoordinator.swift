//
//  NavCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyNavCoordinator: NSObject, Coordinator {

    private var childCoordinators: [Coordinator] = []

    private let rootViewController: UIViewController

    private let navigationController: UINavigationController

    private weak var delegate: MyNavCoordinatorDelegate?

    var associatedScenes: [Scene] {
        return [.navA, .navB, .navC]
    }

    // MARK: - Initialization

    init(rootViewController: UIViewController, delegate: MyNavCoordinatorDelegate? = nil) {
        self.rootViewController = rootViewController
        self.navigationController = UINavigationController()
        self.delegate = delegate
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene, associatedScenes.contains(scene) else {
            throw RoutingError.unsupportedRoute
        }

        let vc = try makeViewController(with: scene)
        navigationController.viewControllers = [vc]
        navigationController.presentationController?.delegate = self
        rootViewController.present(navigationController, animated: animated, completion: nil)

        guard let nextRoute = route.remainingRoute() else { return }
        try navigate(to: nextRoute, animated: animated)
    }

    func start(animated: Bool) {
        try! navigate(to: Route(scenes: [.navA], userIntent: nil), animated: animated)
    }

    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated) {
            self.delegate?.coordinatorDidFinish(self)
        }
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate

extension MyNavCoordinator: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.coordinatorDidFinish(self)
    }

}

// MARK: - Private

private func makeViewController(with scene: Scene) throws -> UIViewController {
    let sb = UIStoryboard(name: "Main", bundle: .main)
    switch scene {
    case .navA:
        return sb.instantiateViewController(identifier: NavAViewController.identifier) { (coder) -> NavAViewController? in
            let vm = NavAViewModel()
            return NavAViewController(coder: coder, viewModel: vm)
        }
    case .navB:
        return sb.instantiateViewController(identifier: NavBViewController.identifier) { (coder) -> NavBViewController? in
            let vm = NavBViewModel()
            return NavBViewController(coder: coder, viewModel: vm)
        }
    case .navC:
        return sb.instantiateViewController(identifier: NavCViewController.identifier) { (coder) -> NavCViewController? in
            let vm = NavCViewModel()
            return NavCViewController(coder: coder, viewModel: vm)
        }
    default: throw RoutingError.invalidScene
    }
}

// MARK: - Delegate

protocol MyNavCoordinatorDelegate: CoordinatorDelegate { }
