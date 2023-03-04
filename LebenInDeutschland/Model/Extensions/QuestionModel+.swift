//
//  QuestionModel+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

extension QuestionModel {
    var examQuestionUnanswered: ExamQuestion {
        ExamQuestion(question: self, selectedAnswer: .none)
    }
    
    var examQuestionAnsweredCorrectly: ExamQuestion {
        ExamQuestion(question: self, selectedAnswer: self.correctAnswer ?? .none)
    }
    
    var examQuestionAnsweredWrongly: ExamQuestion {
        ExamQuestion(question: self, selectedAnswer: self.answers.first(where: { !$0.isCorrect }) ?? .none)
    }
}
