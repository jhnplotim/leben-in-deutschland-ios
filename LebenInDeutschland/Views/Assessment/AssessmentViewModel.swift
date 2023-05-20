//
//  AssessmentManager.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI
import Combine

final class AssessmentViewModel: ObservableObject {

    private var attemptMgr: AttemptManager

    @Published private(set) var assessmentQuestions: [AssessmentQuestion] = []

    @Published var currentAssessmentQuestion: AssessmentQuestion = .none

    @Published private(set) var summary: AssessmentSummary = .none
    
    @Published var assessmentTitle: String = ""
    
    @Published var timeRemaining: String = ""
    private var timeLeftInSeconds: TimeInterval
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var currentQuestionIndex: Int

    private var currentAssessmentType: AssessmentType
    
    private var _questionService: QuestionService

    init(attemptManager: AttemptManager, assessmentType: AssessmentType, questionService: some QuestionService) {
        currentQuestionIndex = 0
        attemptMgr = attemptManager
        currentAssessmentType = assessmentType
        _questionService = questionService
        assessmentTitle = currentAssessmentType.title
        timeLeftInSeconds = currentAssessmentType.duration ?? -1
    }

    var assessmentLoaded: Bool {
        !assessmentQuestions.isEmpty
    }

    var questionCount: Int {
        assessmentQuestions.count
    }

    var currentQuestionPosition: Int {
        currentQuestionIndex + 1
    }
    
    var showTimer: Bool {
        currentAssessmentType.showTimer
    }

    func initialise() {
        currentQuestionIndex = 0
        loadQuestions()
        loadCurrentQuestion()
        updateSummary()
        print("Assessment (\(currentAssessmentType) initialised")
    }

    func deInitialise() {
        saveAssessmentResults()
        currentAssessmentQuestion = .none
        summary = .none
        currentQuestionIndex = 0
        print("Questions unloaded")
    }

    func saveAssessmentResults() {
        if !assessmentQuestions.isEmpty {
            attemptMgr.saveAttempt(questions: assessmentQuestions, for: currentAssessmentType)
        } else {
            print("No questions available to save")
        }
    }

    private func loadQuestions() {
        assessmentQuestions = _questionService.getAssessmentQuestions(for: currentAssessmentType)
    }

    func loadCurrentQuestion() {
        guard !assessmentQuestions.isEmpty else {
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
        assessmentQuestions[currentQuestionIndex] = assessmentQuestion
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
        let answeredCount = assessmentQuestions.filter { $0.isAnswered }.count
        let correctlyAnsweredCount = assessmentQuestions.filter { $0.isCorrectlyAnswered }.count

        summary.questionCount = questionCount
        summary.questionCountUnanswered = questionCount - answeredCount
        summary.questionCountAnsweredCorrectly = correctlyAnsweredCount
        summary.questionCountAnsweredWrongly = answeredCount - correctlyAnsweredCount
    }
    
    // TODO: Maintain result over various sessions / db
    @discardableResult
    func toggleCurrentAsFavorite() -> Bool {
        
        let currentQuestion = assessmentQuestions[currentQuestionIndex]
        
        guard let updatedQnModel = _questionService.toggleQuestionAsFavorite(currentQuestion.id) else {
            print("Question with ID \(currentQuestion.id) could not be found")
            return false
        }
        
        let updatedCurrentQuestion = currentQuestion.makeCopy(with: updatedQnModel)
        assessmentQuestions[currentQuestionIndex] = updatedCurrentQuestion
        loadCurrentQuestion()
        print("Toggle of question with ID \(currentQuestion.id) successful")
        return true
    }
    
    func updateTime() {
        // TODO: Finish assessment when timer gets to zero
        timeLeftInSeconds = max(0, timeLeftInSeconds - 1)

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional

        let formattedString = formatter.string(from: TimeInterval(timeLeftInSeconds))!
        timeRemaining = formattedString
    }

    deinit {
        print("De-initialising Assessment manager")
    }
}
