//
//  QuestionDetailModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import SwiftUI

final class QuestionDetailModel {
    
    var position: Int
    
    var assessmentQuestion: AssessmentQuestion

    var attemptMgrFactory: () -> AttemptManager = {
        DIResolver.shared.resolve(AttemptManager.self)!
    }
    
    init(curPos: Int, qn: AssessmentQuestion) {
        position = curPos
        assessmentQuestion = qn
    }
    
    // For testing purposes / previews
    init(curPos: Int, qn: AssessmentQuestion, attMgrFactory: @autoclosure @escaping () -> AttemptManager) {
        position = curPos
        assessmentQuestion = qn
        attemptMgrFactory = attMgrFactory
    }
    
    func getChosenAnswers() -> [Bool] {
        attemptMgrFactory().getChosenAnswers(for: assessmentQuestion.question.id).map { $0.wasCorrect ?? false }
    }
}
