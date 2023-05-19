//
//  AttemptManager.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Combine

enum ExamAttemptState {
    case noneAttempted
    case attempted(exams: [CompletedExam])
    
    var count: Int {
        switch self {
        case .attempted(exams: let exams):
            return exams.count

        default:
            return 0
        }
    }
}

enum QuestionAttemptState {
    case noneAttempted
    case attempted(answers: [ChosenAnswer])
    
    var count: Int {
        switch self {
        case .attempted(answers: let qns):
            return qns.count

        default:
            return 0
        }
    }
}

protocol AttemptManager {
    var examState: AnyPublisher<ExamAttemptState, Never> { get }
    var questionAttemptState: AnyPublisher<QuestionAttemptState, Never> { get }
    
    @discardableResult
    func saveAttempt(questions: [AssessmentQuestion], for assessment: AssessmentType) -> Bool
    
    func getChosenAnswers(for questionId: Int) -> [ChosenAnswer]

}
