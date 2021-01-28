//
//  FirstCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/21/20.
//

import UIKit


final class FirstCoordinator: Coordinator {

    static var associatedScenes: [Scene] {
        [.first]
    }

    // MARK: - Private properties

    weak var delegate: FirstCoordinatorDelegate?

    private var myModalCoordinator: MyModalCoordinator?

    private var myNavCoordinator: MyNavCoordinator?

    private let application: MyTestApplication

    private let rootViewController: UIViewController

    private let firstViewController: FirstViewController

    // MARK: - Initialization

    init(application: MyTestApplication, rootViewController: UIViewController, delegate: FirstCoordinatorDelegate? = nil) {
        self.delegate = delegate
        self.application = application
        self.rootViewController = rootViewController
        self.firstViewController = getViewControllerFromStoryboard(providing: application)
    }

    // MARK: - Methods

    func navigateToNavViewChild(_ scene: Scene, isOutOfOrder: Bool = false) {
        var scenes: [Scene] = isOutOfOrder ? [.navB] : [.navA]

        switch scene {
        case .navA where isOutOfOrder:
            scenes += [.navA]
        case .navB:
            scenes += [.navB]
        case .navC:
            scenes += isOutOfOrder ? [.navA, .navC] : [.navB, .navC]
        default:
            break
        }

        try! navigate(to: Route(scenes: scenes, userIntent: nil), animated: true)
    }

    /// Dismisses this coordinator's children, going back to the root view of this coordinator. Use this method to present a new set
    /// of children when the dismissal finishes in the completion block.
    /// - Parameters:
    ///   - animated: Whether to animate the dismissal.
    ///   - completion: A block invoked upon dismissal completion.
    func dismissToRoot(animated: Bool, completion: (()  -> Void)?) {
        dismissChildren(animated: animated, completion: completion)
    }

    // MARK: - Coordinator

    static func canHandle(scene: Scene) -> Bool {
        guard case .first = scene else { return false }

        return true
    }

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else {
            throw RoutingError.unsupportedRoute
        }

        switch scene {
        case .first:
            firstViewController.viewModel.flowDelegate = self
            firstViewController.modalPresentationStyle = .fullScreen
            rootViewController.present(firstViewController, animated: animated, completion: nil)
        case _ where MyNavCoordinator.canHandle(scene: scene):
            myNavCoordinator = MyNavCoordinator(rootViewController: firstViewController, delegate: self)
            try myNavCoordinator?.navigate(to: route, animated: animated)
            return
        case _ where MyModalCoordinator.canHandle(scene: scene):
            myModalCoordinator = MyModalCoordinator(rootViewController: firstViewController, delegate: self)
            try myModalCoordinator?.navigate(to: route, animated: animated)
            return
        default:
            throw RoutingError.invalidScene
        }

        guard let remainingRoute = route.remainingRoute() else { return }
        try navigate(to: remainingRoute, animated: animated)
    }

    func start(animated: Bool) {
        let route = Route(scenes: [.first], userIntent: nil)
        try! navigate(to: route, animated: animated)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        dismissChildren(animated: animated) {
            self.firstViewController.dismiss(animated: animated) {
                self.delegate?.coordinatorDidFinish(self)
                completion?()
            }
        }
    }

}

// MARK: - FirstViewModelFlowDelegate

extension FirstCoordinator: FirstViewModelFlowDelegate {

    func didSelectNavButton() {
        try! navigate(to: Route(scenes: [.navA], userIntent: nil), animated: true)
    }

    func didSelectModalButton() {
        try! navigate(to: Route(scenes: [.myModal], userIntent: nil), animated: true)
    }

    func didSelectModalChildButton() {
        try! navigate(to: Route(scenes: [.myModal, .myModalChild], userIntent: nil), animated: true)
    }

    func didSelectNavBButton() {
        navigateToNavViewChild(.navB)
    }

    func didSelectNavCButton() {
        navigateToNavViewChild(.navC)
    }

    func didSelectNavAButtonOutOfOrder() {
        navigateToNavViewChild(.navA, isOutOfOrder: true)
    }

    func didSelectNavCButtonOutOfOrder() {
        navigateToNavViewChild(.navC, isOutOfOrder: true)
    }

    func didSelectLogOut() {
        delegate?.didSelectLogOut()
        dismiss(animated: true)
    }

}

// MARK: - Private

private extension FirstCoordinator {

    /// Dismisses the child coordinators back to this coordinator's root view controller.
    func dismissChildren(animated: Bool, completion: (() -> Void)? = nil) {
        var dismissalCount = 0
        let expectedCount =
            (myNavCoordinator != nil ? 1 : 0) +
            (myModalCoordinator != nil ? 1 : 0)

        let dismissalCompletion = {
            dismissalCount += 1
            if dismissalCount == expectedCount {
                completion?()
            }
        }

        if expectedCount == 0 {
            completion?()
        } else {
            ([myNavCoordinator, myModalCoordinator] as [Coordinator?]).forEach {
                $0?.dismiss(animated: animated, completion: dismissalCompletion)
            }
        }
    }

}

func getViewControllerFromStoryboard(providing application: MyTestApplication) -> FirstViewController {
    let sb = UIStoryboard(name: "Main", bundle: .main)
    return sb.instantiateViewController(identifier: FirstViewController.identifier) { (coder) -> FirstViewController? in
        let vm = FirstViewModel(application: application)
        return FirstViewController(coder: coder, viewModel: vm)
    }
}

// MARK: - Coordinator delegates

extension FirstCoordinator: MyNavCoordinatorDelegate, MyModalCoordinatorDelegate {

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        switch coordinator {
        case is MyModalCoordinator:
            myModalCoordinator = nil
        case is MyNavCoordinator:
            myNavCoordinator = nil
        default:
            break
        }
    }

}

// MARK: - Delegate

protocol FirstCoordinatorDelegate: CoordinatorDelegate {

    /// Called when the user selects the log out button.
    func didSelectLogOut()

}
