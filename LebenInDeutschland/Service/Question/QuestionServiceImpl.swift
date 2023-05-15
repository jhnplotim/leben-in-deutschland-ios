//
//  QuestionServiceImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

final class QuestionServiceImpl: QuestionService {
    
    enum C {
        static let jsonFile = "questions.json"
    }
    
    private var allQuestions: [QuestionModel]
    
    init() {
        allQuestions = load(C.jsonFile)
    }
    
    func getAllQuestions() -> [QuestionModel] {
        allQuestions
    }
    
    func getQuestions(for category: Int) -> [QuestionModel] {
        allQuestions.filter { qn in qn.categoryId == category}
    }
}
