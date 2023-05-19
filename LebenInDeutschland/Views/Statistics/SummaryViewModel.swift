//
//  SummaryViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 18.05.23.
//

import Foundation
import Combine

final class SummaryViewModel: ObservableObject {
    
    @Published var examState: ExamAttemptState = .noneAttempted
    
    @Published var questionAttemptState: QuestionAttemptState = .noneAttempted
    
    private var attemptMgr: AttemptManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(attemptMgr: AttemptManager) {
        self.attemptMgr = attemptMgr
        self.attemptMgr.examState.sink(receiveValue: { [weak self] state in
            self?.examState = state
        }).store(in: &cancellables)
        
        self.attemptMgr.questionAttemptState.sink(receiveValue: { [weak self] state in
            self?.questionAttemptState = state
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
