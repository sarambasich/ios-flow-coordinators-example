//
//  DeepLinkParser.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/3/20.
//

import Foundation


/// Parses a deep link URL into a list of scenes the app can handle.
struct DeepLinkParser {

    private let URL: URL

    init(URL: URL) {
        self.URL = URL
    }

    /// Parse the URL into a `Route`.
    func parse() throws -> Route {
        let pathComponents = URL.pathComponents

        guard pathComponents.isEmpty == false else {
            throw DeepLinkParserError.emptyPath
        }

        guard URL.host == "mydomain.com" else {
            throw DeepLinkParserError.invalidHost
        }

        let scenes: [Scene] = try pathComponents.map { (pathComponent) in
            do {
                return try Scene.convertToScene(from: pathComponent)
            } catch DeepLinkConversionError.unknownScene {
                throw DeepLinkParserError.invalidPath
            }
        }

        return Route(scenes: scenes, userIntent: URL)
    }

}

enum DeepLinkParserError: Error {

    case invalidHost

    case emptyPath

    case invalidPath

}
