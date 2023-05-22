//
//  AssessmentType.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

enum AssessmentType: Equatable, Hashable, Identifiable {

    case exam(stateId: String, generalCount: Int = 30, stateCount: Int = 3)
    case state(stateId: String, count: Int = 10)
    case general(count: Int = 100)
    case category(categoryId: Int)
    case bookMark(bookMarkId: String)
    case favorite
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
            
        case .category(_):
            return "Category Assessment"
            
        case .bookMark(_):
            return "Bookmark Assessment"
            
        case .favorite:
            return "Favorites Assessment"
            
        case .questions(_, title: let title):
            return title + "Assessment"
            
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
