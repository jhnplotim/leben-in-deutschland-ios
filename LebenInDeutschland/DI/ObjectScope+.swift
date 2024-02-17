//
//  ObjectScope+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Swinject

// Define CustomScopes here
extension ObjectScope {
    // Define custom scopes that is similar to the .container (singleton) scope but may be cleared as and when required e.g. when the user logs out, clear the objects in memory e.g. UserSession.
    // See https://github.com/Swinject/Swinject/blob/master/Documentation/ObjectScopes.md
    // See https://ali-akhtar.medium.com/ios-dependency-injection-using-swinject-9c4ceff99e41
    static let customSingleton = ObjectScope(storageFactory: PermanentStorage.init)
}
