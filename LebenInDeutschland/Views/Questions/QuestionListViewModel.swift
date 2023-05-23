//
//  QuestionListViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 22.05.23.
//

import Foundation

final class QuestionListViewModel: ObservableObject {
    enum C {
        static let pageTitle = "Questions"
    }
    
    private(set) var questionIds: [Int]
    private var _attemptManager: AttemptManager
    private var _questionService: QuestionService
    
    @Published var questions: [QuestionRow.Model] = []
    
    @Published var pageTitle: String
    
    @Published var assessmentToShow: AssessmentType?
    
    init(questionService: QuestionService, attemptManager: AttemptManager, _ qnIds: [Int], displayTitle: String = C.pageTitle) {
        pageTitle = displayTitle
        questionIds = qnIds
        _questionService = questionService
        _attemptManager = attemptManager
    }
    
    func fetchQuestions() {
        questions = _questionService.getQuestions(by: questionIds).getRowModels(attemptMgr: _attemptManager)
    }
    
    func showPractice(_ displayTitle: String, qnId: Int? = nil) {
        if let qnId {
            assessmentToShow = .questions(qnIds: [qnId], title: displayTitle)
        } else {
            assessmentToShow = .questions(qnIds: questionIds, title: displayTitle)
        }
    }
    
}
