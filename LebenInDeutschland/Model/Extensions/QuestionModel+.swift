//
//  QuestionModel+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

extension QuestionModel {
    var assessmentQuestionUnanswered: AssessmentQuestion {
        AssessmentQuestion(question: self, selectedAnswer: .none)
    }

    var assessmentQuestionAnsweredCorrectly: AssessmentQuestion {
        AssessmentQuestion(question: self, selectedAnswer: self.correctAnswer ?? .none)
    }

    var assessmentQuestionAnsweredWrongly: AssessmentQuestion {
        AssessmentQuestion(question: self, selectedAnswer: self.answers.first(where: { !$0.isCorrect }) ?? .none)
    }
}
