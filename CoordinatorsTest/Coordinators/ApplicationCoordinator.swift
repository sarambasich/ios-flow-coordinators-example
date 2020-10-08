//
//  ApplicationCoordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import UIKit


final class ApplicationCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

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

    func start() {
        guard let vc = window.rootViewController as? FirstViewController else { return }
        let vm = FirstViewModel(application: application)
        vc.viewModel = vm
        rootViewController = vc
        window.makeKeyAndVisible()
    }

    // MARK: - Methods



}

// MARK: - FirstViewModelDelegate
