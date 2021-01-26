//
//  SceneInstance.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 1/26/21.
//

import Foundation


struct SceneInstance {

    typealias T = SceneDependencyType

    let scene: Scene

    let dependencies: T

}

func freeform() {
    let s = (Scene.navB, NavBDependencies(floatValue: 32.0))

    switch s {
    case (.navB, _):
        break
    default:
        break
    }
}
