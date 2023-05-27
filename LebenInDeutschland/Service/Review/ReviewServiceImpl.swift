//
//  ReviewServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 27.05.23.
//

import SwiftUI
import StoreKit
// See https://developer.apple.com/documentation/storekit/requesting_app_store_reviews
// See https://ix76y.medium.com/asking-user-to-review-app-in-swiftui-533bd4e503d0
final class ReviewServiceImpl: ReviewService {
    
    func requestReviewManually() {
        // TODO: replace xxxxxxxxxx in the following URL with your Apps Apple ID
        // TODO: Think of how to properly store and inject the Apple ID
         let url = "https://apps.apple.com/app/idxxxxxxxxxx?action=write-review"
         guard let writeReviewURL = URL(string: url)
             else { fatalError("Expected a valid URL") }
         UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    func requestReviewAutomatically() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            // TODO: Implement call back to save the version and avoid asking the user for rating again.
            // See: https://developer.apple.com/documentation/storekit/requesting_app_store_reviews && https://ix76y.medium.com/asking-user-to-review-app-in-swiftui-533bd4e503d0
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive}) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
