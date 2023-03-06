//
//  ChosenAnswer.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 06.03.23.
//

import Foundation

struct ChosenAnswer {
    let id: Int
    let answerId: String?
    let wasCorrect: Bool?
    let questionId: String
    let dateTimeAdded: Date
    let examId: Int?
}
