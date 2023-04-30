//
//  GaugeType.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 28.03.23.
//

import Foundation
import SwiftUI

var percentageFormatter: NumberFormatter {
    let fm = NumberFormatter()
    fm.numberStyle = .percent
    fm.minimumIntegerDigits = 1
    fm.maximumIntegerDigits = 3
    fm.maximumFractionDigits = 1
    return fm
}

enum GaugeType: Identifiable, Hashable {
    case fitForTest(progress: CGFloat)
    case practicedAtleastOnce(progress: CGFloat)
    case lastAnsweredIncorrectly(progress: CGFloat)
    
    var id: Self {
        self
    }
}

extension GaugeType {
    var title: String {
        switch self {
        case .fitForTest:
            return "Fit for the test"
            
        case .practicedAtleastOnce:
            return "Practiced atleast once"
            
        case .lastAnsweredIncorrectly:
            return "Last answered incorrectly"
            
        }
    }
    
    var displayColor: Color {
        switch self {
            
        case .fitForTest:
            return .green
            
        case .practicedAtleastOnce:
            return .orange
            
        case .lastAnsweredIncorrectly:
            return .red
        }
    }
    
    var progress: CGFloat {
        switch self {
            
        case .fitForTest(progress: let progress):
            return progress.withinPercentageRange
            
        case .practicedAtleastOnce(progress: let progress):
            return progress.withinPercentageRange
            
        case .lastAnsweredIncorrectly(progress: let progress):
            return progress.withinPercentageRange
        }
    }
    
    var progressText: String {
        percentageFormatter.string(from: NSNumber(value: progress)) ?? "0 %"
    }
}

extension CGFloat {
    var withinPercentageRange: CGFloat {
        if self > 1 {
            return 1
        } else if self < 0 {
            return 0
        } else {
            return self
        }
    }
}
