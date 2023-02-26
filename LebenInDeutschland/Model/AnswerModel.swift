//
//  AnswerModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import Foundation

struct AnswerModel: Hashable, Codable, Identifiable {
    var id: String
    var text: String
    var isCorrect: Bool
}
