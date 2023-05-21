//
//  QuestionViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import SwiftUI

final class QuestionViewModel {
    
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
    #if DEBUG
    init(curPos: Int, qn: AssessmentQuestion, attMgrFactory: @autoclosure @escaping () -> AttemptManager) {
        position = curPos
        assessmentQuestion = qn
        attemptMgrFactory = attMgrFactory
    }
    #endif
    
    func getChosenAnswers() -> [Bool] {
        attemptMgrFactory().getChosenAnswers(for: assessmentQuestion.question.id).sorted().map { $0.wasCorrect ?? false }
    }
}
