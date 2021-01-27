//
//  Route.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/4/20.
//

import Foundation


struct Route {

    /// The associated list of scene values.
    let scenes: [Scene]

    /// The user intent, that is what the user is ultimately trying to accomplish along with supporting data.
    /// In example this case, our intent can simply be represented by an optional URL. It is optional because
    /// we may wish to leverage the router in case where there isn't any URL but just an arbitrary list of scenes.
    let userIntent: URL?

    /// Convenience get-only accessor to return the first scene in the route if it exists.
    var firstScene: Scene? { scenes.first }

    // MARK: -

    /// Truncates the first scene (FILO) and returns the remaining scenes. If there is only one scene, returns nil.
    /// - Returns: The remaining route after considering the next scene or nil if there are no more scenes.
    func remainingRoute() -> Route? {
        guard scenes.count > 1 else {
            return nil
        }

        return Route(scenes: [Scene](scenes.dropFirst()), userIntent: userIntent)
    }

}


struct Route2 {

    typealias T = AnySceneInstance

    /// The associated list of scene instance values.
    let sceneInstances: [T]

    /// The user intent, that is what the user is ultimately trying to accomplish along with supporting data.
    /// In example this case, our intent can simply be represented by an optional URL. It is optional because
    /// we may wish to leverage the router in case where there isn't any URL but just an arbitrary list of scenes.
    let userIntent: URL?

    /// Convenience get-only accessor to return the first scene instance in the route if it exists.
    var firstSceneInstance: T? { sceneInstances.first }

    // MARK: -

    /// Truncates the first scene (FILO) and returns the remaining scenes. If there is only one scene, returns nil.
    /// - Returns: The remaining route after considering the next scene or nil if there are no more scenes.
    func remainingRoute() -> Route2? {
        guard sceneInstances.count > 1 else {
            return nil
        }

        return Route2(sceneInstances: [T](sceneInstances.dropFirst()), userIntent: userIntent)
    }

}

func freeform() {
    let a = NavAScene(dependencies: NavADependencies(text: "Hi", intValue: 42))
    let b = NavBScene(dependencies: NavBDependencies(floatValue: 13.45))
    let rt = Route2(sceneInstances: [a, b], userIntent: nil)
    let inst = rt.firstSceneInstance

    switch inst {
    case let a as NavAScene:
        print(a)
    default:
        break
    }
}

/// Describes an error that can occur when we try to navigate somewhere with a bad route.
enum RoutingError: Error {

    /// The route contains unsupported scenes.
    case unsupportedRoute

    /// The scene is invalid for the route.
    case invalidScene

}
