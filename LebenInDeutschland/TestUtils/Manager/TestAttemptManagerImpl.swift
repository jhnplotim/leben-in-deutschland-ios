//
//  TestAttemptManagerImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import Foundation
import Combine

final class TestAttemptManagerImpl: AttemptManager {
    func getChosenAnswers(for questionId: Int) -> [ChosenAnswer] {
        []
    }
    
    var examState: AnyPublisher<ExamAttemptState, Never> = Just(ExamAttemptState.attempted(exams: [CompletedExam(id: 0, stateId: FederalState.berlin.id, questionCount: 1, questionCountAnsweredCorrectly: 1, questionCountAnsweredWrongly: 1, questionCountUnanswered: 2, dateTimeStarted: Date(), dateTimeEnded: Date(), passmarkUsed: GlobalC.PASSMARK)])).eraseToAnyPublisher()
    
    var questionAttemptState: AnyPublisher<QuestionAttemptState, Never> = Just(QuestionAttemptState.attempted(answers: [ChosenAnswer(id: 1, answerId: nil, wasCorrect: nil, questionId: 1, dateTimeAdded: Date(), examId: nil)])).eraseToAnyPublisher()
    
    func saveAttempt(questions: [AssessmentQuestion], for assessment: AssessmentType) -> Bool {
        return true
    }
    
}
