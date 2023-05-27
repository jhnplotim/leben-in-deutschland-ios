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
    
    @Published var currentState: FederalState = .noneSelected
    
    private var questionService: QuestionService
    private var attemptMgr: AttemptManager
    private var settingsStore: SettingsStore
    
    private var cancellables = Set<AnyCancellable>()
    
    var hasFailures: Bool {
        seenQuestionsPercentage.questionsRecentlyFailedOnce.count > 0 ||
        seenQuestionsPercentage.questionsRecentlyFailedTwice.count > 0 ||
        seenQuestionsPercentage.questionsRecentlyFailedThrice.count > 0
    }
    
    init(attemptMgr: some AttemptManager, questionService: some QuestionService, settingsStore: some SettingsStore) {
        self.questionService = questionService
        self.attemptMgr = attemptMgr
        self.settingsStore = settingsStore
        
        Publishers.CombineLatest3(self.settingsStore.selectedResidenceStatePublisher, self.attemptMgr.examState, self.attemptMgr.questionAttemptState)
            .sink(receiveValue: { [weak self] residenceState, examState, qAttemptState in
                guard let self else {
                    return
                }
                self.currentState = residenceState
                self.examState = examState.version(for: residenceState)
                let qnIdsForState = self.questionService.getAllQuestions(for: residenceState.id).map { $0.id }
                self.questionAttemptState = qAttemptState.version(for: residenceState, stateQnList: qnIdsForState)
                self.seenQuestionsPercentage = self.questionAttemptState.getPercentage(totalQuestionCount: Double(qnIdsForState.count))
                let seen = self.seenQuestionsPercentage
                self.items = []
                self.items = [ .practicedAtleastOnce(progress: seen.seenOnce),
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
