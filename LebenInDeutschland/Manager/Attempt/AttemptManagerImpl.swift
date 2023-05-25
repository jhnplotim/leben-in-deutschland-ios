//
//  AttemptManagerImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Combine
import SwiftUI

final class AttemptManagerImpl: AttemptManager {
    
    @AppStorage("LebenInDeutschland.chosenAnswers")
    private var chosenAnswers: [ChosenAnswer] = []
    
    @AppStorage("LebenInDeutschland.completedExams")
    private var examsDone: [CompletedExam] = []
    
    // TODO: Manage this differently e.g. UUID
    @AppStorage("LebenInDeutschland.answerCounter")
    private var caCounter: Int = 0

    // TODO: Manage this differently e.g. UUID
    @AppStorage("LebenInDeutschland.examCounter")
    private var exCounter: Int = 0
    
    private var completedExamsSubject = CurrentValueSubject<ExamAttemptState, Never>(.noneAttempted)
    private var chosenAnswersSubject = CurrentValueSubject<QuestionAttemptState, Never>(.noneAttempted)
    
    lazy var examState: AnyPublisher<ExamAttemptState, Never> = completedExamsSubject.share().eraseToAnyPublisher()
    
    lazy var questionAttemptState: AnyPublisher<QuestionAttemptState, Never> = chosenAnswersSubject.share().eraseToAnyPublisher()
    
    init() {
        if !examsDone.isEmpty {
            completedExamsSubject.value = .attempted(exams: examsDone)
        }
        if !chosenAnswers.isEmpty {
            chosenAnswersSubject.value = .attempted(answers: chosenAnswers)
        }
    }
    
    func saveAttempt(questions: [AssessmentQuestion], for assessment: AssessmentType) -> Bool {
        saveQuestionAttempts(questions: questions)
        saveExamAttempt(questions: questions, assessmentType: assessment)
        return true
    }
    
    func getChosenAnswers(for questionId: Int) -> [ChosenAnswer] {
        // TODO: Make decision on ID, int or string (UUID)
        chosenAnswers.filter { $0.questionId == questionId }.sorted() // TODO: Consider sorting at this point and then removing sorting from all other places where this method is used
    }
    
}

// MARK: - Private
extension AttemptManagerImpl {
    private func saveQuestionAttempts(questions: [AssessmentQuestion], at saveTime: Date = Date()) {
        guard !questions.isEmpty else { return }
        chosenAnswers += questions.map { asQn in
            caCounter += 1
            if asQn.selectedAnswer != .none {
                return ChosenAnswer(id: caCounter, answerId: asQn.selectedAnswer.id, wasCorrect: asQn.selectedAnswer.isCorrect, questionId: asQn.question.id, dateTimeAdded: saveTime, examId: nil)
            } else {
                return ChosenAnswer(id: caCounter, answerId: nil, wasCorrect: nil, questionId: asQn.question.id, dateTimeAdded: saveTime, examId: nil)
            }
        }
        
        // Inform subscribers
        chosenAnswersSubject.send(.attempted(answers: chosenAnswers))
    }
    
    private func saveExamAttempt(questions: [AssessmentQuestion], assessmentType: AssessmentType, at saveTime: Date = Date()) {
        
        if !questions.isEmpty, case .exam(stateId: let stateId, generalCount: _, stateCount: _) = assessmentType {
            let answeredCount = questions.filter { $0.isAnswered }.count
            let qnCount = questions.count
            let correctlyAnsweredCount = questions.filter { $0.isCorrectlyAnswered }.count
            exCounter += 1
            examsDone += [
                CompletedExam(
                    id: exCounter,
                    stateId: stateId,
                    questionCount: questions.count,
                    questionCountAnsweredCorrectly: correctlyAnsweredCount,
                    questionCountAnsweredWrongly: answeredCount - correctlyAnsweredCount,
                    questionCountUnanswered: qnCount - answeredCount,
                    dateTimeStarted: saveTime, // TODO: Pass in the correct start time
                    dateTimeEnded: saveTime,
                    passmarkUsed: GlobalC.PASSMARK
                )
            ]
            
            // Inform subscribers
            completedExamsSubject.send(.attempted(exams: examsDone))
        }
    }
}
