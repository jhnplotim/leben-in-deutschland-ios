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

    var id: Self {
        self
    }
}
