//
//  ExamManager.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI
import Combine

final class ExamManager: ObservableObject {
    
    struct ExamSummary {
        var examQuestionCount: Int
        var questionCountAnsweredCorrectly: Int
        var questionCountAnsweredWrongly: Int
        var questionCountUnanswered: Int
        
        static let `none` = ExamSummary(examQuestionCount: 0, questionCountAnsweredCorrectly: 0, questionCountAnsweredWrongly: 0, questionCountUnanswered: 0)
    }
    
    @Published var examQuestions: [ExamQuestion]?
    
    @Published var currentExamQuestion: ExamQuestion = .none
    
    @Published var summary: ExamSummary = .none
    
    private var currentQuestionIndex: Int
    
    init() {
        currentQuestionIndex = 0
    }
    
    var examLoaded: Bool {
        examQuestions != nil
    }
    
    var questionCount: Int {
        examQuestions?.count ?? 0
    }
    
    var currentQuestionPosition: Int {
        currentQuestionIndex + 1
    }
    
    func initialiseExam(for examToLoad: ExamType) {
        currentQuestionIndex = 0
        loadQuestions(for: examToLoad)
        loadCurrentQuestion()
        updateSummary()
        print("Exam initialised")
    }
    
    func deInitialiseExam() {
        saveExamResults()
        examQuestions = nil
        currentExamQuestion = .none
        summary = .none
        currentQuestionIndex = 0
        print("Questions unloaded")
    }
    
    func saveExamResults() {
        // TODO: Implement saving
    }
    
    func loadQuestions(for type: ExamType) {
        // TODO: Load questions from Data Source
        var allQuestions: [QuestionModel] = load("questions.json")
        allQuestions = allQuestions.shuffled()
        
        let generalQuestions = allQuestions.filter{ $0.stateId == nil }
        
        let allStateQuestions = allQuestions.filter{ $0.stateId != nil }
        
        // TODO: Clean up code here
        switch type {
        case .stateExam(stateId: let stateId, generalCount: let generalCount, stateCount: let stateCount):
            let generalQns = generalQuestions.count > generalCount ? generalQuestions[0..<generalCount].map{ $0.examQuestionUnanswered } : generalQuestions.map { $0.examQuestionUnanswered }
            let stateQns = allStateQuestions.filter{ $0.stateId == stateId }
            let chosenStateQns = stateQns.count > stateCount ? stateQns[0..<stateCount].map{ $0.examQuestionUnanswered } : stateQns.map { $0.examQuestionUnanswered }
            examQuestions = generalQns + chosenStateQns
        case .general(count: let count):
            examQuestions = generalQuestions.count > count ? generalQuestions[0..<count].map{ $0.examQuestionUnanswered } : generalQuestions.map{ $0.examQuestionUnanswered }
        case .category(categoryId: _):
            // TODO: Add support for categories
            examQuestions = generalQuestions.map{ $0.examQuestionUnanswered }
        case .bookMark(bookMarkId: _):
            // TODO: Add support for bookmarks, favorites, read later lists
            examQuestions = generalQuestions.map{ $0.examQuestionUnanswered }
        }
    }
    
    func loadCurrentQuestion() {
        currentExamQuestion = examQuestions?[currentQuestionIndex] ?? .none
    }
    
    func loadNextQuestion() {
        let examQnCount = questionCount
        if examQnCount > 1 {
            currentQuestionIndex = min(currentQuestionIndex + 1, examQnCount - 1)
            loadCurrentQuestion()
        }
    }
    
    func updateCurrentQuestion(examQuestion: ExamQuestion) {
        examQuestions?[currentQuestionIndex] = examQuestion
        updateSummary()
        loadCurrentQuestion()
    }
    
    func loadPreviousQuestion() {
        let examQnCount = questionCount
        if examQnCount > 1 {
            currentQuestionIndex = max(currentQuestionIndex - 1, 0)
            loadCurrentQuestion()
        }
    }
    
    private func updateSummary() {
        let answeredCount = examQuestions?.filter{ $0.isAnswered }.count ?? 0
        let correctlyAnsweredCount = examQuestions?.filter{ $0.isCorrectlyAnswered }.count ?? 0
        
        summary.examQuestionCount = questionCount
        summary.questionCountUnanswered = questionCount - answeredCount
        summary.questionCountAnsweredCorrectly = correctlyAnsweredCount
        summary.questionCountAnsweredWrongly = answeredCount - correctlyAnsweredCount
    }
    
    deinit {
        print("De-initialising Exam manager")
    }
}
