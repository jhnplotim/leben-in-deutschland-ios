//
//  AppDelegate.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 31.05.23.
//

import FirebaseCore
import GoogleMobileAds
import UserMessagingPlatform

// TODO: Republish GDPR message with an updated privacy policy (Very important!!!)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        // Use Firebase library to configure APIs.
        FirebaseApp.configure()
        
		getUMPConsent()
        return true
    }
    
    func getUMPConsent() {
        // Create a UMPRequestParameters object.
        let parameters = UMPRequestParameters()
        // Set tag for under age of consent. Here false means users are not under age.
        parameters.tagForUnderAgeOfConsent = false
        
        // Force a geography
        /*let debugSettings = UMPDebugSettings()
        debugSettings.testDeviceIdentifiers = ["TEST-DEVICE-HASHED-ID"]
        debugSettings.geography = UMPDebugGeography.EEA
        parameters.debugSettings = debugSettings*/
        
        // Request an update to the consent information.
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(
            with: parameters,
            completionHandler: { [self] error in
                if error != nil {
                    print("GADIdentifier: \(BuildConfig.shared.gadAppId)")
                    // Handle the error.
                    print("Consent Update Error: \(error?.localizedDescription)")
                } else {
                    // The consent information state was updated.
                    // You are now ready to check if a form is
                    // available.
                    // The consent information state was updated.
                    // You are now ready to see if a form is available.
                    let formStatus = UMPConsentInformation.sharedInstance.formStatus
                    if formStatus == UMPFormStatus.available {
                        loadForm()
                    }
                }
            })
    }
    
    func loadForm() {
        UMPConsentForm.load(completionHandler: { form, loadError in
            if loadError != nil {
              // Handle the error.
            } else {
              // Present the form. You can also hold on to the reference to present
              // later.
              if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.required {
                form?.present(
                    from: UIApplication.shared.windows.first!.rootViewController! as UIViewController,
                    completionHandler: { [self] _ in
                      if UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatus.obtained {
                        // App can start requesting ads.
                          GADMobileAds.sharedInstance().start(completionHandler: nil)
                        
                      }
                        // Handle dismissal by reloading form.
                        loadForm()
                    })
              } else {
                // Keep the form available for changes to user consent.
              }
            }
          })
    }
}
