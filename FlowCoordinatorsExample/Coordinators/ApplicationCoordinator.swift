//
//  ApplicationCoordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


/*
 ApplicationCoordinator is a special case. It is responsible for managing the root views in the app.
 There are two possible root views. One is the login/authentication view and the other is the "main"
 view once the user logs in. The rationale for doing this is because our target app requires an
 authenticated state in order to do anything meaningful. When we need to clear away and push a new
 set of views, or when we need to log out, this makes reasoning about that easier, rather than making
 the first view post-authentication the child of the login coordinator.

 While this means we break with the philosophy of coordinators only being responsible for one subflow,
 this will ultimately make view management simpler. It is easier to handle wholesale changes in
 views at the root rather than further down the chain, awkwardly handing messages in between via
 function calls. These view changes could happen, for instance, due to session expiration, remote
 notifications, or deep link requests.
 */
final class ApplicationCoordinator: Coordinator {

    static let associatedScenes: [Scene] = []

    // MARK: - Private properties

    private let application: MyTestApplication

    private let window: UIWindow

    private let loginCoordinator: LoginCoordinator

    private var firstCoordinator: FirstCoordinator?

    /// A route to follow after log in in response to an action such as a deep link
    private var pendingRoute: Route?

    // MARK: - Initialization

    init(application: MyTestApplication, window: UIWindow) {
        self.application = application
        self.window = window
        self.loginCoordinator = LoginCoordinator(application: application, window: window)
        self.loginCoordinator.delegate = self
    }

    // MARK: - Methods

    func resetFirstCoordinatorToRoot(animated: Bool, completion: @escaping () -> Void) {
        firstCoordinator?.dismissToRoot(animated: animated, completion: completion)
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else { return }

        switch scene {
        case _ where LoginCoordinator.associatedScenes.contains(scene):
            try loginCoordinator.navigate(to: route, animated: animated)
            return
        case _ where FirstCoordinator.associatedScenes.contains(scene):
            if firstCoordinator == nil {
                firstCoordinator = FirstCoordinator(
                    application: application,
                    rootViewController: loginCoordinator.rootViewController,
                    delegate: self)
            }
            fallthrough
        default:
            try firstCoordinator?.navigate(to: route, animated: animated)
            return
        }
    }

    func start(animated: Bool) {
        let route = Route(scenes: [.login], userIntent: nil)
        try! navigate(to: route, animated: true)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        firstCoordinator?.dismiss(animated: animated)
        loginCoordinator.dismiss(animated: animated)
    }

}

// MARK: - Coordinator delegates

extension ApplicationCoordinator: LoginCoordinatorDelegate, FirstCoordinatorDelegate {

    // MARK: FirstCoordinatorDelegate

    func didSelectLogOut() {
        loginCoordinator.resetToRoot(animated: true)
    }

    // MARK: ChildCoordinatorDelegate

    func coordinatorDidFinish(_ coordinator: Coordinator) {
        if coordinator === loginCoordinator {
            try! navigate(to: pendingRoute ?? Route(scenes: [.first], userIntent: nil), animated: true)
        }
    }

}
