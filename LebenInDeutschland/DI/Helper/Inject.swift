//
//  Inject.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation

// Use property wrapper when sure an instance of the desired type exists. If not, throw a clear error message.
@propertyWrapper
struct Inject<T> {
    private(set) var wrappedValue: T
    
    init() {
        // resolve the interface to an implementation
        // FIXME: Forced unwrapping here causes crashes if depedency does not exist. A better approach is required. Throwing an error is ok but it should be clear
        self.wrappedValue = DIResolver.shared.resolve(T.self)!
    }
    
    init(name: String) throws {
        // resolve the interface to an implementation with a given name
        // FIXME: Forced unwrapping here causes crashes if depedency does not exist. A better approach is required. Throwing an error is ok but it should be clear
        self.wrappedValue = DIResolver.shared.resolve(T.self, name: name)!
    }
}
