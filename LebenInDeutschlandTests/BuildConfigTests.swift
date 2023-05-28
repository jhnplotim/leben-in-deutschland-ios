//
//  BuildConfigTests.swift
//  LebenInDeutschlandTests
//
//  Created by John Paul Otim on 29.05.23.
//

import XCTest
@testable import Leben_in_DE_dev

final class BuildConfigTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEnvironmentSwiftFlags() throws {
        let buildConfig = BuildConfig.shared
        var counter = 0
        let expectedCounterValue = -1
        
        if buildConfig.isStaging {
            counter += 1
        } else {
            counter -= 1
        }
        
        if buildConfig.isDevelopment {
            counter += 1
        } else {
            counter -= 1
        }
        
        if buildConfig.isProduction {
            counter += 1
        } else {
            counter -= 1
        }
    
        XCTAssertEqual(counter, expectedCounterValue, "Environment wrongly setup, only one of the above should return true")
    }
    
    func testReadAppStoreId() throws {
        let buildConfig = BuildConfig.shared
        
        let appStoreId = buildConfig.appStoreId
        
        XCTAssertFalse(appStoreId.isEmpty, "App store id should not be empty")
        
        // TODO: Add test that the default value was replaced
    }
    
    func testReadApiKey() throws {
        let buildConfig = BuildConfig.shared
        
        let apiKey = buildConfig.apiKey
        
        XCTAssertFalse(apiKey.isEmpty, "apiKey should not be empty")
        
        // TODO: Add test that the default value was replaced
    }
    
    func testReadApiBaseUrl() throws {
        let buildConfig = BuildConfig.shared
        
        let apiBaseUrl = buildConfig.apiBaseUrl
        
        XCTAssertFalse(apiBaseUrl.isFileURL, "apiBaseUrl should not be empty")
        
        // TODO: Add test that the default value was replaced
    }

}
