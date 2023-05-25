//
//  SummaryViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Combine

final class SummaryViewModel: ObservableObject {
    
    @Published var seenQuestionsPercentage: QuestionSeenPercentage = .init(
        seenOnce: 0,
        seenTwice: 0,
        seenThrice: 0,
        questionsRecentlyFailedOnce: [],
        questionsRecentlyFailedTwice: [],
        questionsRecentlyFailedThrice: [])
    
    @Published var examState: ExamAttemptState = .noneAttempted
    
    @Published var questionAttemptState: QuestionAttemptState = .noneAttempted
    
    @Published var items: [GaugeType] = []
    
    @Published var examsToShow = 10
    
    private var questionService: QuestionService
    
    private var attemptMgr: AttemptManager
    
    private var cancellables = Set<AnyCancellable>()
    
    var hasFailures: Bool {
        seenQuestionsPercentage.questionsRecentlyFailedOnce.count > 0 ||
        seenQuestionsPercentage.questionsRecentlyFailedTwice.count > 0 ||
        seenQuestionsPercentage.questionsRecentlyFailedThrice.count > 0
    }
    
    init(attemptMgr: AttemptManager, questionService: QuestionService) {
        self.questionService = questionService
        self.attemptMgr = attemptMgr
        self.attemptMgr.examState.sink(receiveValue: { [weak self] state in
            self?.examState = state
        }).store(in: &cancellables)
        
        self.attemptMgr.questionAttemptState.sink(receiveValue: { [weak self] state in
            self?.questionAttemptState = state
            self?.seenQuestionsPercentage = state.getPercentage(totalQuestionCount: Double(questionService.getAllQuestions().count))  // TODO: Use total of only questions for the selected state + general questions
        }).store(in: &cancellables)
        
        self.$seenQuestionsPercentage.sink(receiveValue: { [weak self] seen in
            self?.items = []
            self?.items = [ .practicedAtleastOnce(progress: seen.seenOnce),
                .practicedAtleastTwice(progress: seen.seenTwice),
                      .practicedAtleastThrice(progress: seen.seenThrice)
            ]
        }).store(in: &cancellables)
    }
}

extension SummaryViewModel {
    var examCount: Int {
        examState.count
    }
    
    var questionAttemptCount: Int {
        questionAttemptState.count
    }
}
