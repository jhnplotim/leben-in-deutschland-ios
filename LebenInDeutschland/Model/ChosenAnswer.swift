//
//  ChosenAnswer.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

struct ChosenAnswer: Identifiable, Hashable, Equatable {
    let id: Int // TODO: Consider using UUID here
    let answerId: String?
    let wasCorrect: Bool?
    let questionId: Int
    let dateTimeAdded: Date
    let examId: Int?
}
