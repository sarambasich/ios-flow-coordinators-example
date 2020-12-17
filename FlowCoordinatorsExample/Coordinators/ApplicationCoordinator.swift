//
//  ApplicationCoordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


final class ApplicationCoordinator: Coordinator {

    static var associatedScenes: [Scene] {
        [.first]
    }

    // MARK: - Private properties

    private var myModalCoordinator: MyModalCoordinator?

    private var myNavCoordinator: MyNavCoordinator?

    private let application: MyTestApplication

    private let window: UIWindow

    private let rootViewController: FirstViewController

    // MARK: - Initialization

    init(application: MyTestApplication, window: UIWindow) {
        self.application = application
        self.window = window
        self.rootViewController = window.rootViewController as! FirstViewController
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else { return }

        switch scene {
        case .first:
            rootViewController.viewModel = FirstViewModel(application: application, flowDelegate: self)
            window.makeKeyAndVisible()
        case _ where MyNavCoordinator.associatedScenes.contains(scene):
            myNavCoordinator = MyNavCoordinator(rootViewController: rootViewController, delegate: self)
            try myNavCoordinator?.navigate(to: route, animated: animated)
            return
        case _ where MyModalCoordinator.associatedScenes.contains(scene):
            myModalCoordinator = MyModalCoordinator(rootViewController: rootViewController, delegate: self)
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
        try! navigate(to: route, animated: true)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        var dismissalCount = 0
        let expectedCount =
            (myNavCoordinator != nil ? 1 : 0) +
            (myModalCoordinator != nil ? 1 : 0)

        let dismissalCompletion = {
            dismissalCount += 1
            if dismissalCount == expectedCount { completion?() }
        }

        ([myNavCoordinator, myModalCoordinator] as [Coordinator?]).forEach {
            $0?.dismiss(animated: animated, completion: dismissalCompletion)
        }
    }

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

}

// MARK: - FirstViewModelFlowDelegate

extension ApplicationCoordinator: FirstViewModelFlowDelegate {

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

}

// MARK: - Coordinator delegates

extension ApplicationCoordinator: MyNavCoordinatorDelegate, MyModalCoordinatorDelegate {

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
