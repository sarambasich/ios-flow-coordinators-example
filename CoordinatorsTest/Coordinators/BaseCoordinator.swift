//
//  Coordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import Foundation


protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get }

    func start()

}


protocol CoordinatorDelegate: AnyObject {

    func coordinatorDidFinish(_ coordinator: Coordinator)

}
