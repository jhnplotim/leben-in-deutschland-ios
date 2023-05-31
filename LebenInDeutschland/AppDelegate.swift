//
//  AppDelegate.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 31.05.23.
//

import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      
      // Use Firebase library to configure APIs.
      FirebaseApp.configure()

      // Initialize the Google Mobile Ads SDK.
      GADMobileAds.sharedInstance().start(completionHandler: nil)
      
      return true
  }
}
