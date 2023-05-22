//
//  QuestionService.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation
import Combine

protocol QuestionService {
    var favoritesPublisher: AnyPublisher<[QuestionModel], Never> { get }
    
    func getAllQuestions() -> [QuestionModel]
    func getQuestions(for category: Int) -> [QuestionModel]
    func getQuestions(by ids: [Int]) -> [QuestionModel]
    func getAssessmentQuestions(for assessmentType: AssessmentType) -> [AssessmentQuestion]
    func toggleQuestionAsFavorite(_ questionId: Int) -> QuestionModel?
}
