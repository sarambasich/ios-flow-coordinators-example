//
//  NavCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyNavCoordinator: NSObject, Coordinator {

    static var associatedScenes: [Scene] {
        [.navA, .navB, .navC]
    }

    weak var delegate: MyNavCoordinatorDelegate?

    // MARK: - Private properties

    private let rootViewController: UIViewController

    private let navigationController: UINavigationController

    // MARK: - Initialization

    init(rootViewController: UIViewController, delegate: MyNavCoordinatorDelegate? = nil) {
        self.rootViewController = rootViewController
        self.navigationController = UINavigationController()
        self.delegate = delegate

        super.init()

        self.navigationController.presentationController?.delegate = self
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else {
            throw RoutingError.unsupportedRoute
        }

        guard MyNavCoordinator.associatedScenes.contains(scene) else {
            throw RoutingError.invalidScene
        }

        let vc = try makeViewController(with: scene)
        navigationController.pushViewController(vc, animated: (animated && route.scenes.count == 1))

        if route.scenes.count == 1 && rootViewController.presentedViewController != navigationController {
            rootViewController.present(navigationController, animated: animated, completion: nil)
        }

        guard let nextRoute = route.remainingRoute() else { return }
        try navigate(to: nextRoute, animated: animated)
    }

    func start(animated: Bool) {
        try! navigate(to: Route(scenes: [.navA], userIntent: nil), animated: animated)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated) {
            self.delegate?.coordinatorDidFinish(self)
            completion?()
        }
    }

}

// MARK: - View model delegates

extension MyNavCoordinator: NavAViewModelFlowDelegate, NavBViewModelFlowDelegate, NavCViewModelFlowDelegate {

    // MARK: NavAViewModelFlowDelegate

    func didSelectPushBButton() {
        try! navigate(to: Route(scenes: [.navB], userIntent: nil), animated: true)
    }

    // MARK: NavBViewModelFlowDelegate

    func didSelectPushCButton() {
        try! navigate(to: Route(scenes: [.navC], userIntent: nil), animated: true)
    }

    // MARK: NavCViewModelFlowDelegate

    func didSelectPopToRootButton() {
        navigationController.popToRootViewController(animated: true)
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate

extension MyNavCoordinator: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.coordinatorDidFinish(self)
    }

}

// MARK: - Private

private extension MyNavCoordinator {

    func makeViewController(with scene: Scene) throws -> UIViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        switch scene {
        case .navA:
            return sb.instantiateViewController(identifier: NavAViewController.identifier) { (coder) -> NavAViewController? in
                let vm = NavAViewModel(flowDelegate: self)
                return NavAViewController(coder: coder, viewModel: vm)
            }
        case .navB:
            return sb.instantiateViewController(identifier: NavBViewController.identifier) { (coder) -> NavBViewController? in
                let vm = NavBViewModel(flowDelegate: self)
                return NavBViewController(coder: coder, viewModel: vm)
            }
        case .navC:
            return sb.instantiateViewController(identifier: NavCViewController.identifier) { (coder) -> NavCViewController? in
                let vm = NavCViewModel(flowDelegate: self)
                return NavCViewController(coder: coder, viewModel: vm)
            }
        default: throw RoutingError.invalidScene
        }
    }

}

// MARK: - Delegate

protocol MyNavCoordinatorDelegate: CoordinatorDelegate { }
