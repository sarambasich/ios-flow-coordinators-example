//
//  MyTestApplication.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import Foundation


final class MyTestApplication {

    /// Boolean indicating whether or not the user is authenticated.
    private(set) var isAuthenticated = false

    /// Logs the user into the application.
    func logIn() {
        isAuthenticated = true
    }

    /// Logs the user out of the application.
    func logOut() {
        isAuthenticated = false
    }
    
}
