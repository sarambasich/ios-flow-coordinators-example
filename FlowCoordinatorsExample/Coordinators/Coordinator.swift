//
//  Coordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import Foundation


protocol Coordinator: AnyObject {

    /// The scenes associated with this `Routable` type.
    static var associatedScenes: [Scene] { get }

    /// Start the coordinator and navigate to the provided route, if possible.
    /// - Parameter route: The route to navigate.
    /// - Parameter animated: Whether to animate the transition.
    func navigate(to route: Route, animated: Bool) throws

    /// Start the coordinator from its initial scene.
    /// - Parameter animated: Whether to animate the transition.
    func start(animated: Bool) // TODO: is this redundant now with `navigate(to:)`?

    /// Finishes the coordinator and dismisses its views from the view hierarchy.
    /// - Parameter animated: Whether to animate the transition.
    /// - Parameter completion: A completion block invoked when the dismissal completes.
    func dismiss(animated: Bool, completion: (() -> Void)?)

}

// MARK: - CoordinatorDelegate

/// Delegate to communicate events the coordinator fires.
protocol CoordinatorDelegate: AnyObject {

    /// Called when the coordinator finishes
    func coordinatorDidFinish(_ coordinator: Coordinator)

}
