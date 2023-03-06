//
//  AnswerModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import Foundation

struct AnswerModel: Hashable, Codable, Identifiable, Equatable {
    var id: String
    var text: String
    var isCorrect: Bool
    
    // TODO: Add Question ID / Reference later when DB is integrated
    
    static let `none` = AnswerModel(id: "", text: "", isCorrect: false)
}
