//
//  Environment.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 28.05.23.
//

import Foundation

// Inspired by
// https://medium.com/@hdmdhr/xcode-scheme-environment-project-configuration-setup-recipe-22c940585984
// https://sarunw.com/posts/how-to-set-up-ios-environments/

// If anything goes wrong in here, the app crashes which should not happen but indicates to the developer that something is wrong
// swiftlint:disable all
public enum BuildEnvironment: String {
    
    case debugDevelopment = "Debug (development)"
    case releaseDevelopment = "Release (development)"

    case debugStaging = "Debug (staging)"
    case releaseStaging = "Release (staging)"

    case debugProduction = "Debug (production)"
    case releaseProduction = "Release (production)"
}

class BuildConfig {
    private let infoDictionary: [String: Any]
    
    static let shared = BuildConfig()
    
    var environment: BuildEnvironment
    
    init() {
        /// If cannot find Info.plist, simply crash as it is a developer error and should never happen
        self.infoDictionary = Bundle.main.infoDictionary!
        let currentConfiguration = self.infoDictionary[Keys.configuration.rawValue] as! String
        
        environment = BuildEnvironment(rawValue: currentConfiguration)!
    }
    
    // MARK: - other swift flags
    // https://medium.com/@ankitgoyal4949/how-to-manage-different-environments-and-configurations-for-ios-projects-f55e2425d863
    var isProduction: Bool {
        #if PRODUCTION
        return true
        #else
        return false
        #endif
    }
    
    var isStaging: Bool {
        #if STAGING
        return true
        #else
        return false
        #endif
    }
    
    var isDevelopment: Bool {
        #if DEVELOPMENT
        return true
        #else
        return false
        #endif
    }
}

private extension BuildConfig {
    /// an enum to centralise all keys
    private enum Keys: String {
        case configuration = "Configuration"
        case apiBaseUrl = "API_BASE_URL"
        case apiKey = "API_KEY" // TODO: Look into https://nshipster.com/secrets/ for storage of app secrets
        case appStoreId = "APPSTORE_ID"
    }
}

extension BuildConfig {
    var apiBaseUrl: URL {
        .init(string: infoDictionary[Keys.apiBaseUrl.rawValue] as! String)!
    }
    
    var apiKey: String {
        infoDictionary[Keys.apiKey.rawValue] as! String
    }
    
    var appStoreId: String {
        infoDictionary[Keys.appStoreId.rawValue] as! String
    }
}
