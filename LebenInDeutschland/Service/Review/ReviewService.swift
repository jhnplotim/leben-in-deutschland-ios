//
//  ReviewService.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 27.05.23.
//

import Foundation

// TODO: Consider to interface / protocol segregration i.e. declare two separate protocols for manual and automatic review so it possible to expose only certain functionality of the review service
protocol ReviewService {
    func requestReviewManually()
    
    /// Request review automatically. Care should be taken as to when this method is called to ensure that the user is not bothered. At the moment, this will be used in the attempt manager only when the user has completed at least some number of exams.
    func requestReviewAutomatically()
}
