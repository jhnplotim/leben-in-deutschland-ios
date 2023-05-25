//
//  QuestionModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

// TODO: Consider making class
struct QuestionModel: Hashable, Codable, Identifiable, Equatable {
    var id: Int
    var title: String
    var imageLink: URL?
    var answers: [AnswerModel]
    var stateId: String?
    var categoryId: Int?
    var isFavorite: Bool? = false // TODO: Make it Not nilable later
    // TODO: Consider saving list of favorites separately from the questions & have a favorites service responsible for managing them e.g. add, update, read, delete

    var correctAnswer: AnswerModel? {
        answers.first(where: { $0.isCorrect })
    }

    static let `none` = QuestionModel(id: 0, title: "", imageLink: nil, answers: [], stateId: nil, categoryId: nil, isFavorite: false)
    
    func makeCopy() -> QuestionModel {
        QuestionModel(id: id, title: title, imageLink: imageLink, answers: answers, stateId: stateId, categoryId: categoryId, isFavorite: isFavorite)
    }
    
    func makeCopyToggledFavorite() -> QuestionModel {
        var value = makeCopy()
        value.isFavorite = !(value.isFavorite ?? false)
        return value
    }
}
