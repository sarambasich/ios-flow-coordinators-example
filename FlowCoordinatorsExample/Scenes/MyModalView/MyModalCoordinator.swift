//
//  MyModalCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


class MyModalCoordinator: NSObject, Coordinator {

    static var associatedScenes: [Scene] {
        [.myModal]
    }

    weak var delegate: MyModalCoordinatorDelegate?

    // MARK: - Private properties

    private let rootViewController: UIViewController

    private var myModalViewController: MyModalViewController?

    private var myModalChildCoordinator: MyModalChildCoordinator?

    // MARK: - Initialization

    init(rootViewController: UIViewController, delegate: MyModalCoordinatorDelegate? = nil) {
        self.rootViewController = rootViewController
        self.delegate = delegate

        super.init()
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else {
            throw RoutingError.unsupportedRoute
        }

        switch scene {
        case .myModal:
            myModalViewController = getModalViewControllerFromStoryboard()
            myModalViewController?.presentationController?.delegate = self
            rootViewController.present(myModalViewController!, animated: animated && route.scenes.count == 1, completion: nil)
        case _ where MyModalChildCoordinator.associatedScenes.contains(scene):
            guard rootViewController.presentedViewController == myModalViewController else {
                throw RoutingError.unsupportedRoute
            }

            myModalChildCoordinator = MyModalChildCoordinator(rootViewController: myModalViewController!, delegate: self)
            try myModalChildCoordinator?.navigate(to: route, animated: animated)
            return
        default:
            throw RoutingError.invalidScene
        }

        guard let route = route.remainingRoute() else { return }
        try navigate(to: route, animated: animated)
    }

    func start(animated: Bool) {
        try! navigate(to: Route(scenes: [.myModal], userIntent: nil), animated: animated)
    }

    func dismiss(animated: Bool) {
        myModalViewController?.dismiss(animated: animated) {
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

// MARK: - MyModalViewModelFlowDelegate

extension MyModalCoordinator: MyModalViewModelFlowDelegate {

    func didSelectGoToModalChildButton() {
        try! navigate(to: Route(scenes: [.myModalChild], userIntent: nil), animated: true)
    }

}

// MARK: - MyModalChildCoordinatorDelegate

extension MyModalCoordinator: MyModalChildCoordinatorDelegate {

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        guard coordinator === myModalChildCoordinator else { return }

        myModalChildCoordinator = nil
    }

}

// MARK: - Private

private extension MyModalCoordinator {

    func getModalViewControllerFromStoryboard() -> MyModalViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: MyModalViewController.identifier) { (coder) -> MyModalViewController? in
            let vm = MyModalViewModel(flowDelegate: self)
            return MyModalViewController(coder: coder, viewModel: vm)
        }
    }

}

// MARK: - Delegate

protocol MyModalCoordinatorDelegate: CoordinatorDelegate { }
