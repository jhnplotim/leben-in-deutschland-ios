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
    
    func initialiseExam() {
        currentQuestionIndex = 0
        loadAllQuestions()
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
    
    func loadAllQuestions() {
        // TODO: Load based on state chosen or category
        let allQuestions: [QuestionModel] = load("questions.json")
        examQuestions = allQuestions.map{ $0.examQuestionUnanswered }
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
