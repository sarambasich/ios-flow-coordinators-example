//
//  ApplicationCoordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


final class ApplicationCoordinator: Coordinator {

    private var childCoordinators: [Coordinator] = []

    var associatedScenes: [Scene] {
        return [.first]
    }

    // MARK: - Private properties

    private let application: MyTestApplication

    private let window: UIWindow

    private var rootViewController: FirstViewController?

    // MARK: - Initialization

    init(application: MyTestApplication, window: UIWindow) {
        self.application = application
        self.window = window
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene, scene == .first else {
            throw RoutingError.invalidScene
        }

        rootViewController = window.rootViewController as? FirstViewController
        rootViewController?.viewModel = FirstViewModel(application: application, flowDelegate: self)
        window.makeKeyAndVisible()

        // Recursive case: since this coordinator is a special case and is the start, it only
        // supports navigation to one scene, the initial scene. For subsequent coordinators,
        // we may still have additional scenes to go to.
        guard let remainingRoute = route.remainingRoute() else { return }
        try navigate(to: remainingRoute, animated: animated)
    }

    func start(animated: Bool) {
        let route = Route(scenes: [.first], userIntent: nil)
        try! navigate(to: route, animated: true)
    }

    func dismiss(animated: Bool) {
        print("Invalid call to `dismiss` - can't dismiss root application coordinator!")
    }

    // MARK: Navigation handling

    func navigateToNavView() {
        guard let rootViewController = rootViewController else { return }

        let coordinator = MyNavCoordinator(rootViewController: rootViewController, delegate: self)
        coordinator.start(animated: true)

        childCoordinators.append(coordinator)
    }

    func navigateToModalView() {
        guard let rootViewController = rootViewController else { return }

        let coordinator = MyModalCoordinator(rootViewController: rootViewController, delegate: self)
        coordinator.start(animated: true)

        childCoordinators.append(coordinator)
    }

}

// MARK: - FirstViewModelFlowDelegate

extension ApplicationCoordinator: FirstViewModelFlowDelegate {

    func didSelectNavButton() {
        navigateToNavView()
    }

    func didSelectModalButton() {
        navigateToModalView()
    }

}

// MARK: - Coordinator delegates

extension ApplicationCoordinator: MyNavCoordinatorDelegate, MyModalCoordinatorDelegate {

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }

}
