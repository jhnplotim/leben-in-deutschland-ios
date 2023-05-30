//
//  QuestionServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import SwiftUI
import Combine

final class QuestionServiceImpl: QuestionService {
    enum C {
        static let jsonFile = "questions.json"
    }
    
    @AppStorage("LebenInDeutschland.allQuestions")
    private var allQuestions: [QuestionModel] = load(C.jsonFile)
    
    private var favoritesPassthroughSubject = CurrentValueSubject<[QuestionModel], Never>([])
    
    lazy var favoritesPublisher: AnyPublisher<[QuestionModel], Never> = favoritesPassthroughSubject.share().eraseToAnyPublisher()
    
    init() {
        updateFavorites()
    }
    
    func getAllQuestions() -> [QuestionModel] {
        allQuestions
    }
    
    func getCategoryQuestions(for category: Int) -> [QuestionModel] {
        allQuestions.filter { qn in qn.categoryId == category}
    }
    
    func toggleQuestionAsFavorite(_ questionId: Int) -> QuestionModel? {
        guard let curIndex = allQuestions.firstIndex(where: { $0.id == questionId}) else {
            // Could not find question with that ID
            return nil
        }
        var temp = allQuestions
        temp[curIndex] = temp[curIndex].makeCopyToggledFavorite()
        allQuestions = temp // save new list of questions
        updateFavorites()
        return allQuestions[curIndex]
        
    }
    
    func getAssessmentQuestions(for assessmentType: AssessmentType) -> [AssessmentQuestion] {
        
        var shuffledQuestions = allQuestions.shuffled()

        let generalQuestions = shuffledQuestions.filter { $0.stateId == nil }

        let allStateQuestions = shuffledQuestions.filter { $0.stateId != nil }

        // TODO: Clean up code here
        switch assessmentType {
        case .exam(stateId: let stateId, generalCount: let generalCount, stateCount: let stateCount):
            let generalQns = generalQuestions.count > generalCount ? generalQuestions[0..<generalCount].map { $0.assessmentQuestionUnanswered } : generalQuestions.map { $0.assessmentQuestionUnanswered }
            let stateQns = allStateQuestions.filter { $0.stateId == stateId }
            let chosenStateQns = stateQns.count > stateCount ?
            stateQns[0..<stateCount].map { $0.assessmentQuestionUnanswered } :
            stateQns.map { $0.assessmentQuestionUnanswered }
            return generalQns + chosenStateQns

        case .state(stateId: let stateId, count: let count):
            let stateQns = allStateQuestions.filter { $0.stateId == stateId }
            let chosenStateQns = stateQns.count > count ? stateQns[0..<count].map { $0.assessmentQuestionUnanswered } : stateQns.map { $0.assessmentQuestionUnanswered }
            return chosenStateQns

        case .general(count: let count):
            return generalQuestions.count > count ? generalQuestions[0..<count].map { $0.assessmentQuestionUnanswered } : generalQuestions.map { $0.assessmentQuestionUnanswered }
    
        case .bookMark:
            // TODO: Add support for bookmarks, favorites, read later lists
            return generalQuestions.map { $0.assessmentQuestionUnanswered }
            
        case .questions(qnIds: let ids, _):
            return allQuestions.filter { ids.contains($0.id) }.map { $0.assessmentQuestionUnanswered }
        }
    }
    
    func getQuestions(by ids: [Int]) -> [QuestionModel] {
        allQuestions.filter { qn in ids.contains(qn.id)}
    }
    
    func getAllGeneralQuestions() -> [QuestionModel] {
        getAllQuestions().filter { $0.stateId == nil }
    }
    
    func getStateQuestions(for stateId: Int) -> [QuestionModel] {
        getAllQuestions().filter { $0.stateId == stateId }
    }
    
    func getAllQuestions(for stateId: Int) -> [QuestionModel] {
        allQuestions.filter { $0.stateId == nil || $0.stateId == stateId }
    }
}

// MARK: - Private functions
extension QuestionServiceImpl {
    private func updateFavorites() {
        favoritesPassthroughSubject.send(allQuestions.filter { $0.isFavorite ?? false })
    }
}
