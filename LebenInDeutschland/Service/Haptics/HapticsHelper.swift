//
//  HapticsHelper.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import UIKit

enum Vibration {
    case success
    case warning
    case error
    
    var notificationType: UINotificationFeedbackGenerator.FeedbackType {
        switch self {
        case .success:
            return .success
            
        case .warning:
            return .warning
            
        case .error:
            return .error
        }
    }
}

/// Vibrate
/// - Parameter vibration: Kind of vibration to use. This defaults to error
func vibrate(_ vibration: Vibration = .error) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(vibration.notificationType)
}
