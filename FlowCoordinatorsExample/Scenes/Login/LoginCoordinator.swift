//
//  LoginCoordinator.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/21/20.
//

import UIKit


final class LoginCoordinator: Coordinator {

    static var associatedScenes: [Scene] {
        [.login, .loginChallenge]
    }

    // MARK: - Properties

    let rootViewController: UINavigationController

    private let application: MyTestApplication

    private let window: UIWindow

    private let loginViewController: LoginViewController

    weak var delegate: LoginCoordinatorDelegate?

    // MARK: - Initialization

    init(application: MyTestApplication, window: UIWindow, delegate: LoginCoordinatorDelegate? = nil) {
        self.application = application
        self.window = window
        self.rootViewController = window.rootViewController as! UINavigationController
        self.loginViewController = rootViewController.viewControllers.first as! LoginViewController
        self.delegate = delegate
    }

    // MARK: - Coordinator

    func navigate(to route: Route, animated: Bool) throws {
        guard let scene = route.firstScene else {
            throw RoutingError.unsupportedRoute
        }

        switch scene {
        case .login:
            loginViewController.viewModel = LoginViewModel(application: application, flowDelegate: self)
            window.makeKeyAndVisible()
        case .loginChallenge:
            let vc = getChallengeViewControllerFromStoryboard()
            rootViewController.pushViewController(vc, animated: animated)
        default:
            throw RoutingError.invalidScene
        }

        guard let remainingRoute = route.remainingRoute() else { return }
        try navigate(to: remainingRoute, animated: animated)
    }

    func start(animated: Bool) {
        let route = Route(scenes: [.login], userIntent: nil)
        try! navigate(to: route, animated: animated)
    }

    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        loginViewController.viewModel = LoginViewModel(application: application, flowDelegate: self)
        rootViewController.setViewControllers([loginViewController], animated: animated)
        completion?()
    }

    // MARK: - Methods

    /// Resets the login coordinator to the initial view to initiate another login session.
    func resetToRoot(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
    
}

// MARK: - LoginViewModelFlowDelegate

extension LoginCoordinator: LoginViewModelFlowDelegate {

    func didLogIn() {
        try! navigate(to: Route(scenes: [.loginChallenge], userIntent: nil), animated: true)
    }

}

// MARK: - LoginViewModelFlowDelegate

extension LoginCoordinator: LoginChallengeViewModelFlowDelegate {

    func didSelectSubmitChallenge() {
        delegate?.coordinatorDidFinish(self)
    }

}

// MARK: - Private

private extension LoginCoordinator {

    func getChallengeViewControllerFromStoryboard() -> LoginChallengeViewController {
        let sb = UIStoryboard(name: "Login", bundle: .main)
        return sb.instantiateViewController(identifier: LoginChallengeViewController.identifier) { (coder) -> LoginChallengeViewController? in
            let vm = LoginChallengeViewModel(application: self.application, flowDelegate: self)
            return LoginChallengeViewController(coder: coder, viewModel: vm)
        }
    }

}

// MARK: - Delegate

protocol LoginCoordinatorDelegate: CoordinatorDelegate { }
