//
//  AssessmentType.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

enum AssessmentType: Equatable, Hashable, Identifiable {

    // TODO: Remove any un-necessary types after the un-needed view have been removed e.g. state & bookmark
    case exam(stateId: String, generalCount: Int = 30, stateCount: Int = 3)
    case state(stateId: String, count: Int = 10)
    case general(count: Int = 100)
    case bookMark(bookMarkId: String)
    case questions(qnIds: [Int], title: String)

    var id: Self {
        self
    }
}

extension AssessmentType {
    var title: String {
        switch self {
        case .exam(_, _, _):
            return "Exam"
            
        case .state(_, _):
            return "State Assessment"
            
        case .general(_):
            return "General Assessment"
            
        case .bookMark(_):
            return "Bookmark Assessment"
            
        case .questions(_, title: let title):
            return title + " Assessment"
            
        }
    }
    
    var isTimed: Bool {
        switch self {
        case .exam:
            return true
            
        default:
            return false
        }
    }
    
    var duration: TimeInterval? {
        switch self {
        case .exam:
            #if DEBUG
            return 200
            #else
            return 3600 // 1 hr
            #endif
            
        default:
            return nil
        }
    }
}
