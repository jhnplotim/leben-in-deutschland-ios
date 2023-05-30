//
//  ChosenAnswer.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

struct ChosenAnswer: Identifiable, Hashable, Equatable, Codable, Comparable {
    static func < (lhs: ChosenAnswer, rhs: ChosenAnswer) -> Bool {
        lhs.dateTimeAdded > rhs.dateTimeAdded
    }
    
    let id: Int // TODO: Consider using UUID here
    let answerId: Int?
    let wasCorrect: Bool?
    let questionId: Int
    let dateTimeAdded: Date
    let examId: Int?
}
