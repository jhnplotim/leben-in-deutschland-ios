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
        exams.count
    }
    
    var exams: [CompletedExam] {
        switch self {
        case .attempted(exams: let exams):
            return exams

        default:
            return []
        }
    }
    
    var orderedPassOrFails: [Bool] {
        // TODO: Consider only those exams for the selected state
        let temp = exams.sorted()
        return temp.map { $0.passed }
    }
    
    func version(for state: FederalState) -> ExamAttemptState {
        if case .attempted(let exams) = self {
            let examsForState = exams.filter { $0.stateId == state.id }
            return examsForState.isEmpty ? .noneAttempted : .attempted(exams: examsForState)
        } else {
            return self
        }
    }
}

enum QuestionAttemptState {
    case noneAttempted
    case attempted(answers: [ChosenAnswer])
    
    var count: Int {
        answers.count
    }
    
    var answers: [ChosenAnswer] {
        switch self {
        case .attempted(answers: let answers):
            return answers

        default:
            return []
        }
    }
    
    func version(for state: FederalState, stateQnList: [Int]) -> QuestionAttemptState {
        if case .attempted(let answers) = self {
            let answersForState = answers.filter { stateQnList.contains($0.questionId) }
            return answersForState.isEmpty ? .noneAttempted : .attempted(answers: answersForState)
        } else {
            return self
        }
    }
    
    func getPercentage(totalQuestionCount: Double) -> QuestionSeenPercentage {
        let answers = answers // TODO: Use only attempts for the selected state + general questions
        guard !answers.isEmpty else {
            return .init(
                seenOnce: 0,
                seenTwice: 0,
                seenThrice: 0,
                questionsRecentlyFailedOnce: [],
                questionsRecentlyFailedTwice: [],
                questionsRecentlyFailedThrice: []
            )
        }
        
        let attemptedAtleastOnce = Dictionary(grouping: answers, by: { $0.questionId })
        let attemptedAtleastTwice = attemptedAtleastOnce.filter { $0.value.count >= 2 }
        let attemptedAtleastThrice = attemptedAtleastTwice.filter { $0.value.count >= 3}
        
        // Retrieve questionIds failed, once, twice, thrice, four times and five time
        // TODO: Change approach i.e. base on count of failures of 5 most recent attempts and not consecutive failures (seems to make more sense)
        // TODO: Then group by count and extract failed 1,2...5 (Last one, 5 is the only consecutive)
        let recentlyFailedAtleastOnce = attemptedAtleastOnce.filter { !($0.value.sorted()[0].wasCorrect ?? false) }
        let recentlyFailedAtleastTwice = recentlyFailedAtleastOnce.filter { $0.value.count >= 2 && !($0.value.sorted()[1].wasCorrect ?? false) }
        let recentlyFailedAtleastThrice = recentlyFailedAtleastTwice.filter { $0.value.count >= 3 && !($0.value.sorted()[2].wasCorrect ?? false) }
        
        return QuestionSeenPercentage(
            seenOnce: Double(attemptedAtleastOnce.count) / totalQuestionCount,
            seenTwice: Double(attemptedAtleastTwice.count) / totalQuestionCount,
            seenThrice: Double(attemptedAtleastThrice.count) / totalQuestionCount,
            questionsRecentlyFailedOnce: recentlyFailedAtleastOnce.map { $0.key },
            questionsRecentlyFailedTwice: recentlyFailedAtleastTwice.map { $0.key },
            questionsRecentlyFailedThrice: recentlyFailedAtleastThrice.map { $0.key })
        
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
    let questionsRecentlyFailedOnce: [Int]
    let questionsRecentlyFailedTwice: [Int]
    let questionsRecentlyFailedThrice: [Int]
    
}
