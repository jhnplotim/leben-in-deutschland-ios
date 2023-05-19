//
//  QuestionService.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

protocol QuestionService {
    func getAllQuestions() -> [QuestionModel]
    func getQuestions(for category: Int) -> [QuestionModel]
    func getAssessmentQuestions(for assessmentType: AssessmentType) -> [AssessmentQuestion]
    func toggleQuestionAsFavorite(_ questionId: Int) -> QuestionModel?
}
