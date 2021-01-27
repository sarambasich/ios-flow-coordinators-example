//
//  SceneInstance.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 1/26/21.
//

import Foundation


protocol AnySceneInstance { }


protocol SceneInstance: AnySceneInstance {

    associatedtype DependencyType = SceneDependencyType

    var scene: Scene { get }

    var dependencies: DependencyType { get }

}

struct NavAScene: SceneInstance {

    let scene: Scene = .navA

    let dependencies: NavADependencies
}

struct NavBScene: SceneInstance {

    let scene: Scene = .navB

    let dependencies: NavBDependencies
}

