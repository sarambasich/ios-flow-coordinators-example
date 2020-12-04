//
//  Coordinator.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import Foundation


protocol Coordinator: AnyObject {

    /// Child coordinators belonging to this parent coordinator.
    var childCoordinators: [Coordinator] { get }

    /// Start the coordinator.
    func start()

}


/// Delegate to communicate events the coordinator fires.
protocol CoordinatorDelegate: AnyObject {

    /// Called when the coordinator finishes
    func coordinatorDidFinish(_ coordinator: Coordinator)

}
