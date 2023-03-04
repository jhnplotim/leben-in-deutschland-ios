//
//  ExamType.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

enum ExamType {
    case stateExam(stateId: String, generalCount: Int = 30, stateCount: Int = 3)
    case general(count: Int = 100)
    case category(categoryId: String)
    case bookMark(bookMarkId: String)
}
