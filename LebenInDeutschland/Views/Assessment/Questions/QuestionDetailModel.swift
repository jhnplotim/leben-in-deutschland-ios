//
//  QuestionDetailModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import SwiftUI
import UIKit

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
    #if DEBUG
    init(curPos: Int, qn: AssessmentQuestion, attMgrFactory: @autoclosure @escaping () -> AttemptManager) {
        position = curPos
        assessmentQuestion = qn
        attemptMgrFactory = attMgrFactory
    }
    #endif
    
    func getChosenAnswers() -> [Bool] {
        attemptMgrFactory().getChosenAnswers(for: assessmentQuestion.question.id).map { $0.wasCorrect ?? false }
    }
    
    func copyToClipBoard() {
        let pasteboard = UIPasteboard.general
        var valueToCopy = "\(assessmentQuestion.question.title) \n"
        
        for ansEnum in assessmentQuestion.question.answers.enumerated() {
            valueToCopy += "\(ansEnum.offset + 1) \(ansEnum.element.text) \n"
        }
        pasteboard.string = valueToCopy
    }
}
