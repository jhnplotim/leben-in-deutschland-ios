//
//  QuestionModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionModel: Hashable, Codable, Identifiable, Equatable {
    var id: String
    var title: String
    var imageLink: URL?
    var answers: [AnswerModel]
    var stateId: String?
    var categoryId: Int?
    var isFavorite: Bool? = false

    var correctAnswer: AnswerModel? {
        answers.first(where: { $0.isCorrect })
    }

    static let `none` = QuestionModel(id: "", title: "", imageLink: nil, answers: [], stateId: nil, categoryId: nil, isFavorite: false)
    
    func makeCopy() -> QuestionModel {
        QuestionModel(id: id, title: title, imageLink: imageLink, answers: answers, stateId: stateId, categoryId: categoryId, isFavorite: isFavorite)
    }
    
    func makeCopyToggledFavorite() -> QuestionModel {
        var value = makeCopy()
        value.isFavorite = !(value.isFavorite ?? false)
        return value
    }
}
