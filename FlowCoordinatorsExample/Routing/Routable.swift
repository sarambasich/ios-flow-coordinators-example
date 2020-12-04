//
//  Routable.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/3/20.
//

import Foundation


/// Describes an entity who is able to route to scenes it or its children control.
protocol Routable: class {

    /// The scenes associated with this `Routable` instance
    var associatedScenes: [Scene] { get }

    /// Determines whether this `Routable` can support routing to all of the constituent scenes in the given route.
    /// - Parameter route: The route to check this entity's support for.
    func canSupportScenes(in route: Route) -> Bool

    /// Perform navigation using the provided route if possible.
    /// - Parameter route: The route to navigate.
    func navigate(to route: Route) throws

}

/// Describes an error that can occur when we try to `route` somewhere using `Routable`
enum RoutingError: Error {

    /// The route contains unsupported scenes
    case unsupportedRoute

    /// The scene is invalid for the route.
    case invalidScene

}
