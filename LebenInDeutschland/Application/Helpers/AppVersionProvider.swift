//
//  AppVersionProvider.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 27.05.23.
//

import Foundation

enum AppVersionProvider {
    static var currentAppVersion: String {
        // Get the current bundle version for the app.
        let infoDictionaryKey = kCFBundleVersionKey as String
        
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary.") }
        
        return currentVersion
    }
}
