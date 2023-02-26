//
//  QuestionModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionModel: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var imageLink: URL?
    var answers: [AnswerModel]
    var stateId: String?
    
    
    var correctAnswer: AnswerModel? {
        answers.first(where: { $0.isCorrect == true })
    }
}
