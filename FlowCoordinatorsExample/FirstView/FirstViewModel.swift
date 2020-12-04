//
//  FirstViewModel.swift
//  CoordinatorTest
//
//  Created by Stefan Arambasich on 10/8/20.
//

import Foundation


class FirstViewModel {

    /// The title for the view
    var title: String {
        "First View Controller"
    }

    /// The body text for the view
    var bodyText: String {
        "Hello, I am some fake body text."
    }

    // MARK: - Private properties

    private let application: MyTestApplication

    // MARK: - Initialization

    init(application: MyTestApplication) {
        self.application = application
    }

}


protocol FirstViewModelFlowDelegate {

    

}
