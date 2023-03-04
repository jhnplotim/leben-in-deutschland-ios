//
//  ExamQuestion+.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import Foundation

extension ExamQuestion {
    var isAnswered: Bool {
        self.selectedAnswer != .none
    }
    
    var isCorrectlyAnswered: Bool {
        return isAnswered && (self.selectedAnswer == self.question.correctAnswer)
    }
}
