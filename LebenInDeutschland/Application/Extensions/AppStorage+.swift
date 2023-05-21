//
//  AppStorage+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 21.05.23.
//

import Foundation
// Make Array supported by SwiftUI @AppStorage property wrapper
// See https://stackoverflow.com/questions/62562534/swiftui-what-is-appstorage-property-wrapper/62563773#62563773
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
