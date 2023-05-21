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
    
    var answers: [ChosenAnswer] {
        switch self {
        case .attempted(answers: let answers):
            return answers

        default:
            return []
        }
    }
    
    func getPercentage(totalQuestionCount: Double) -> QuestionSeenPercentage {
        let answers = answers // TODO: Use only attempts for the selected state + general questions
        guard !answers.isEmpty else {
            return .init(seenOnce: 0, seenTwice: 0, seenThrice: 0)
        }
        
        let attemptedAtleastOnce = Dictionary(grouping: answers, by: { $0.questionId })
        let attemptedAtleastTwice = attemptedAtleastOnce.filter { $0.value.count >= 2 }
        let attemptedAtleastThrice = attemptedAtleastTwice.filter { $0.value.count >= 3}
              
        return QuestionSeenPercentage(
            seenOnce: Double(attemptedAtleastOnce.count) / totalQuestionCount,
            seenTwice: Double(attemptedAtleastTwice.count) / totalQuestionCount,
            seenThrice: Double(attemptedAtleastThrice.count) / totalQuestionCount)
        
    }
}

protocol AttemptManager {
    var examState: AnyPublisher<ExamAttemptState, Never> { get }
    var questionAttemptState: AnyPublisher<QuestionAttemptState, Never> { get }
    
    @discardableResult
    func saveAttempt(questions: [AssessmentQuestion], for assessment: AssessmentType) -> Bool
    
    func getChosenAnswers(for questionId: Int) -> [ChosenAnswer]

}

struct QuestionSeenPercentage {
    let seenOnce: Double
    let seenTwice: Double
    let seenThrice: Double
}
