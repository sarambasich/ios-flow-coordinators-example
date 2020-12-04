//
//  ApplicationCoordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


final class ApplicationCoordinator: Coordinator, Routable {

    var childCoordinators: [Coordinator] = []

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

    func start(animated: Bool) {
        guard let vc = window.rootViewController as? FirstViewController else { return }
        let vm = FirstViewModel(application: application)
        vc.viewModel = vm
        rootViewController = vc
        window.makeKeyAndVisible()
    }

    // MARK: Programmatic child handling

    func navigateToModalView() {
        guard let rootViewController = rootViewController else { return }

        let coordinator = MyModalCoordinator(rootViewController: rootViewController)
        coordinator.start(animated: true)

        childCoordinators.append(coordinator)
    }

    // MARK: - Segue child handling

    func didNavigateUsingModalSegue(_ modalViewController: MyModalViewController) {
        guard let rootViewController = rootViewController else { return }

        let coordinator = MyModalCoordinator(rootViewController: rootViewController,
                                             fromSegueModalController: modalViewController)

        childCoordinators.append(coordinator)
    }

    // MARK: - Routable

    func canSupportScenes(in route: Route) -> Bool {
        return route.scenes == [.first]
    }

    func navigate(to route: Route) throws {
        guard let scene = route.scenes.first, scene == .first else {
            throw RoutingError.invalidScene
        }

        start(animated: true)

        // Recursive case: since this coordinator is a special case and is the start, it only
        // supports navigation to one scene, the initial scene. For subsequent coordinators,
        // we may still have additional
        guard let remainingRoute = route.remainingRoute() else { return }
        try navigate(to: remainingRoute)
    }

}
