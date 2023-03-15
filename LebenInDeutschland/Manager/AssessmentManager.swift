//
//  AssessmentManager.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI
import Combine

final class AssessmentManager: ObservableObject {

    struct AssessmentSummary: Hashable, Equatable, CustomStringConvertible {
        var questionCount: Int
        var questionCountAnsweredCorrectly: Int
        var questionCountAnsweredWrongly: Int
        var questionCountUnanswered: Int

        var progress: CGFloat {
            CGFloat(questionCount - questionCountUnanswered) / CGFloat(questionCount)
        }

        var description: String {
                return "AssessmentSummary { \n QN Count: \(questionCount), \n CORRECT: \(questionCountAnsweredCorrectly), \n WRONG: \(questionCountAnsweredWrongly), \n UNANSWERED: \(questionCountUnanswered) \n }"
            }

        var score: CGFloat {
            Double(questionCountAnsweredCorrectly) / Double(questionCount)
        }
        var passed: Bool {
            score >= GlobalC.PASSMARK
        }

        static let `none` = AssessmentSummary(questionCount: 0, questionCountAnsweredCorrectly: 0, questionCountAnsweredWrongly: 0, questionCountUnanswered: 0)
    }

    @Published private(set) var assessmentQuestions: [AssessmentQuestion]?

    @Published var currentAssessmentQuestion: AssessmentQuestion = .none

    @Published private(set) var summary: AssessmentSummary = .none

    private var currentQuestionIndex: Int

    private var currentAssessmentType: AssessmentType?

    // TODO: Move this into proper location. Also, it should be pre-loaded from memory
    @Published private(set) var chosenAnswers: [ChosenAnswer] = []

    // TODO: Move this into proper location. Also, it should be pre-loaded from memory
    @Published private(set) var examsDone: [CompletedExam] = []

    // TODO: Manage this differently
    @AppStorage("LebenInDeutschland.answerCounter")
    private var caCounter: Int = 0

    // TODO: Manage this differently
    @AppStorage("LebenInDeutschland.examCounter")
    private var exCounter: Int = 0

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
        currentAssessmentType = nil
        print("Questions unloaded")
    }

    func saveAssessmentResults() {
        // TODO: Implement saving (in a reactive way) to a data store
        chosenAnswers += assessmentQuestions?.map { asQn in
            caCounter += 1
            if asQn.selectedAnswer != .none {
                return ChosenAnswer(id: caCounter, answerId: asQn.selectedAnswer.id, wasCorrect: asQn.selectedAnswer.isCorrect, questionId: asQn.question.id, dateTimeAdded: Date(), examId: nil)
            } else {
                return ChosenAnswer(id: caCounter, answerId: nil, wasCorrect: nil, questionId: asQn.question.id, dateTimeAdded: Date(), examId: nil)
            }
        } ?? []

        if let currentAssessmentType, let assessmentQuestions, !assessmentQuestions.isEmpty, case .exam(stateId: let stateId, generalCount: _, stateCount: _) = currentAssessmentType, summary != .none {
            exCounter += 1
            examsDone += [CompletedExam(id: exCounter, stateId: stateId, questionCount: summary.questionCount, questionCountAnsweredCorrectly: summary.questionCountAnsweredCorrectly, questionCountAnsweredWrongly: summary.questionCountAnsweredWrongly, questionCountUnanswered: summary.questionCountUnanswered, dateTimeStarted: Date(), dateTimeEnded: Date())]
        }
    }

    func loadQuestions(for assessmentType: AssessmentType) {
        // TODO: Load questions from Data Source
        currentAssessmentType = assessmentType

        var allQuestions: [QuestionModel] = load("questions.json")
        allQuestions = allQuestions.shuffled()

        let generalQuestions = allQuestions.filter { $0.stateId == nil }

        let allStateQuestions = allQuestions.filter { $0.stateId != nil }

        // TODO: Clean up code here
        switch assessmentType {
        case .exam(stateId: let stateId, generalCount: let generalCount, stateCount: let stateCount):
            let generalQns = generalQuestions.count > generalCount ? generalQuestions[0..<generalCount].map { $0.assessmentQuestionUnanswered } : generalQuestions.map { $0.assessmentQuestionUnanswered }
            let stateQns = allStateQuestions.filter { $0.stateId == stateId }
            let chosenStateQns = stateQns.count > stateCount ?
            stateQns[0..<stateCount].map { $0.assessmentQuestionUnanswered } :
            stateQns.map { $0.assessmentQuestionUnanswered }
            assessmentQuestions = generalQns + chosenStateQns

        case .state(stateId: let stateId, count: let count):
            let stateQns = allStateQuestions.filter { $0.stateId == stateId }
            let chosenStateQns = stateQns.count > count ? stateQns[0..<count].map { $0.assessmentQuestionUnanswered } : stateQns.map { $0.assessmentQuestionUnanswered }
            assessmentQuestions = chosenStateQns

        case .general(count: let count):
            assessmentQuestions = generalQuestions.count > count ? generalQuestions[0..<count].map { $0.assessmentQuestionUnanswered } : generalQuestions.map { $0.assessmentQuestionUnanswered }

        case .category:
            // TODO: Add support for categories
            assessmentQuestions = generalQuestions.map { $0.assessmentQuestionUnanswered }

        case .bookMark:
            // TODO: Add support for bookmarks, favorites, read later lists
            assessmentQuestions = generalQuestions.map { $0.assessmentQuestionUnanswered }

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
        let answeredCount = assessmentQuestions?.filter { $0.isAnswered }.count ?? 0
        let correctlyAnsweredCount = assessmentQuestions?.filter { $0.isCorrectlyAnswered }.count ?? 0

        summary.questionCount = questionCount
        summary.questionCountUnanswered = questionCount - answeredCount
        summary.questionCountAnsweredCorrectly = correctlyAnsweredCount
        summary.questionCountAnsweredWrongly = answeredCount - correctlyAnsweredCount
    }

    deinit {
        print("De-initialising Assessment manager")
    }
}
