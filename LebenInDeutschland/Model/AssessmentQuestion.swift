//
//  AssessmentQuestion.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

struct AssessmentQuestion: Hashable, Codable, Identifiable, Equatable {
    let question: QuestionModel
    var selectedAnswer: AnswerModel = .none
    
    var id: String {
        question.id
    }
    
    static let `none` = AssessmentQuestion(question: .none, selectedAnswer: .none)
}
