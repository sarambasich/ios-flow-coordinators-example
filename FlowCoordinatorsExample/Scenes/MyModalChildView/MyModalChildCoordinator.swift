//
//  MyModalChildCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/14/20.
//

import UIKit


class MyModalChildCoordinator: NSObject, Coordinator {

//    static var associatedScenes: [Scene] {
//        [.myModalChild]
//    }

    weak var delegate: MyModalChildCoordinatorDelegate?

    // MARK: - Private properties

    private let rootViewController: UIViewController

    private var myModalChildViewController: MyModalChildViewController?

    // MARK: - Initialization

    init(rootViewController: UIViewController, delegate: MyModalChildCoordinatorDelegate? = nil) {
        self.rootViewController = rootViewController
        self.delegate = delegate

        super.init()
    }

    // MARK: - Coordinator

    static func canHandle(scene: Scene) -> Bool {
        guard case .myModalChild = scene else { return false }
        return true
    }

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else {
            throw RoutingError.unsupportedRoute
        }

        guard case .myModalChild = scene else {
            throw RoutingError.invalidScene
        }

        myModalChildViewController = getViewControllerFromStoryboard()
        myModalChildViewController?.presentationController?.delegate = self
        rootViewController.present(myModalChildViewController!, animated: animated, completion: nil)
    }

    func start(animated: Bool) {
        try! navigate(to: Route(scenes: [.myModalChild], userIntent: nil), animated: animated)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        myModalChildViewController?.dismiss(animated: animated) {
            self.delegate?.coordinatorDidFinish(self)
            completion?()
        }
    }

}

// MARK: - MyModalChildViewModelFlowDelegate

extension MyModalChildCoordinator: MyModalChildViewModelFlowDelegate {

    func didSelectTriggerDismiss() {
        // Makes a call to scene delegate to swap the current view hierarchy for a new set of scenes.
        // This tests the dismiss-then-present functionality of thse coordinators.
        // Calling this will ultimately dismiss this coordinator and each of its ancestor coordinators.
        // That way, we do not have to manually invoked a call to self's `dismiss` here.
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.swapCurrentScenesForNavScenes()
    }

}

// MARK: - UIAdaptivePresentationControllerDelegate

extension MyModalChildCoordinator: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.coordinatorDidFinish(self)
    }

}

// MARK: - Private

private extension MyModalChildCoordinator {

    func getViewControllerFromStoryboard() -> MyModalChildViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        return sb.instantiateViewController(identifier: MyModalChildViewController.identifier) { (coder) -> MyModalChildViewController? in
            let vm = MyModalChildViewModel(flowDelegate: self)
            return MyModalChildViewController(coder: coder, viewModel: vm)
        }
    }

}

// MARK: - Delegate

protocol MyModalChildCoordinatorDelegate: CoordinatorDelegate { }
