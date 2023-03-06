//
//  AssessmentManager.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI
import Combine

final class AssessmentManager: ObservableObject {
    
    struct AssessmentSummary {
        var questionCount: Int
        var questionCountAnsweredCorrectly: Int
        var questionCountAnsweredWrongly: Int
        var questionCountUnanswered: Int
        
        static let `none` = AssessmentSummary(questionCount: 0, questionCountAnsweredCorrectly: 0, questionCountAnsweredWrongly: 0, questionCountUnanswered: 0)
    }
    
    @Published private(set) var assessmentQuestions: [AssessmentQuestion]?
    
    @Published var currentAssessmentQuestion: AssessmentQuestion = .none
    
    @Published private(set) var summary: AssessmentSummary = .none
    
    private var currentQuestionIndex: Int
    
    private var currentAssessmentType: AssessmentType?
    
    init() {
        currentQuestionIndex = 0
    }
    
    var assessmentLoaded: Bool {
        assessmentQuestions != nil
    }
    
    var questionCount: Int {
        assessmentQuestions?.count ?? 0
    }
    
    var currentQuestionPosition: Int {
        currentQuestionIndex + 1
    }
    
    func initialise(for assessmentType: AssessmentType) {
        currentQuestionIndex = 0
        loadQuestions(for: assessmentType)
        loadCurrentQuestion()
        updateSummary()
        print("Assessment (\(assessmentType) initialised")
    }
    
    func deInitialise() {
        saveAssessmentResults()
        assessmentQuestions = nil
        currentAssessmentQuestion = .none
        summary = .none
        currentQuestionIndex = 0
        print("Questions unloaded")
    }
    
    func saveAssessmentResults() {
        // TODO: Implement saving
    }
    
    func loadQuestions(for assessmentType: AssessmentType) {
        // TODO: Load questions from Data Source
        currentAssessmentType = assessmentType
        
        var allQuestions: [QuestionModel] = load("questions.json")
        allQuestions = allQuestions.shuffled()
        
        let generalQuestions = allQuestions.filter{ $0.stateId == nil }
        
        let allStateQuestions = allQuestions.filter{ $0.stateId != nil }
        
        // TODO: Clean up code here
        switch assessmentType {
        case .exam(stateId: let stateId, generalCount: let generalCount, stateCount: let stateCount):
            let generalQns = generalQuestions.count > generalCount ? generalQuestions[0..<generalCount].map{ $0.assessmentQuestionUnanswered } : generalQuestions.map { $0.assessmentQuestionUnanswered }
            let stateQns = allStateQuestions.filter{ $0.stateId == stateId }
            let chosenStateQns = stateQns.count > stateCount ? stateQns[0..<stateCount].map{ $0.assessmentQuestionUnanswered } : stateQns.map { $0.assessmentQuestionUnanswered }
            assessmentQuestions = generalQns + chosenStateQns
            
        case .state(stateId: let stateId, count: let count):
            let stateQns = allStateQuestions.filter{ $0.stateId == stateId }
            let chosenStateQns = stateQns.count > count ? stateQns[0..<count].map{ $0.assessmentQuestionUnanswered } : stateQns.map { $0.assessmentQuestionUnanswered }
            assessmentQuestions = chosenStateQns
            
        case .general(count: let count):
            assessmentQuestions = generalQuestions.count > count ? generalQuestions[0..<count].map{ $0.assessmentQuestionUnanswered } : generalQuestions.map{ $0.assessmentQuestionUnanswered }
            
        case .category(categoryId: _):
            // TODO: Add support for categories
            assessmentQuestions = generalQuestions.map{ $0.assessmentQuestionUnanswered }
            
        case .bookMark(bookMarkId: _):
            // TODO: Add support for bookmarks, favorites, read later lists
            assessmentQuestions = generalQuestions.map{ $0.assessmentQuestionUnanswered }
            
        }
    }
    
    func loadCurrentQuestion() {
        guard let assessmentQuestions, !assessmentQuestions.isEmpty else {
            print("AssessmentQuestions are null or empty")
            return
        }
        currentAssessmentQuestion = assessmentQuestions[currentQuestionIndex]
    }
    
    func loadNextQuestion() {
        let assessQnCount = questionCount
        if assessQnCount > 1 {
            currentQuestionIndex = min(currentQuestionIndex + 1, assessQnCount - 1)
            loadCurrentQuestion()
        }
    }
    
    func updateCurrentQuestion(assessmentQuestion: AssessmentQuestion) {
        assessmentQuestions?[currentQuestionIndex] = assessmentQuestion
        updateSummary()
        loadCurrentQuestion()
    }
    
    func loadPreviousQuestion() {
        let assessQnCount = questionCount
        if assessQnCount > 1 {
            currentQuestionIndex = max(currentQuestionIndex - 1, 0)
            loadCurrentQuestion()
        }
    }
    
    private func updateSummary() {
        let answeredCount = assessmentQuestions?.filter{ $0.isAnswered }.count ?? 0
        let correctlyAnsweredCount = assessmentQuestions?.filter{ $0.isCorrectlyAnswered }.count ?? 0
        
        summary.questionCount = questionCount
        summary.questionCountUnanswered = questionCount - answeredCount
        summary.questionCountAnsweredCorrectly = correctlyAnsweredCount
        summary.questionCountAnsweredWrongly = answeredCount - correctlyAnsweredCount
    }
    
    deinit {
        print("De-initialising Assessment manager")
    }
}
