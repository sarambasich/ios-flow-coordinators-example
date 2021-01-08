//
//  Scene.swift
//  FlowCoordinatorsExample
//
//  Created by Stefan Arambasich on 12/3/20.
//

import Foundation


/// A scene represents one view of a screen at a time.
/// This could also be represented using a struct for more dynamic behavior such as hot swapping screens and to facilitate
/// (de-)serialization for representation on disk for example. This would have the advantage of de-coupling the exhaustive list of
/// screens from a hard-coded enumeration, which may not be desirable or scalable for large apps.
enum Scene: String {

    // MARK: - Cases

    case login

    case loginChallenge = "login_challenge"

    case first

    case myModal = "my_modal"

    case myModalChild = "my_modal_child"

    case navA = "nav_a"

    case navB = "nav_b"

    case navC = "nav_c"

}

extension Scene: DeepLinkConvertible {

    /// Attempts to convert the given path component to a known scene value. Throws
    /// `DeepLinkConversionError.unknownScene` if unable to transform.
    static func convertToScene(from pathComponent: String) throws -> Scene {
        guard let scene = Scene(rawValue: pathComponent) else {
            throw DeepLinkConversionError.unknownScene
        }

        return scene
    }

}
