//
//  DeepLinkConvertible.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/3/20.
//

import Foundation


/// Describes an entity who is able to fashion a representation of itself from a deep link URL.
protocol DeepLinkConvertible {

    /// Convert the given path component string into a `Scene` value if possible.
    static func convertToScene(from pathComponent: String) throws -> Scene

}

/// Describes an error that can occur when we try to convert from a string component to a scene
enum DeepLinkConversionError: Error, Equatable {

    case unknownScene

}

