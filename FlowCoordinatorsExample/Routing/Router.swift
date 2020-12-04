//
//  Router.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/3/20.
//

import UIKit


class Router {

    let entryPoint: Routable

    init(entryPoint: Routable) {
        self.entryPoint = entryPoint

    }

    func start(with initialRoute: Route) throws {
        guard entryPoint.canSupportScenes(in: initialRoute) else {
            throw RoutingError.unsupportedRoute
        }

        try entryPoint.navigate(to: initialRoute)
    }

}
