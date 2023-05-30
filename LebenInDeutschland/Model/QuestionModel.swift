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
    var image: UIImage? // TODO: Fix the issue with the images
    var answers: [AnswerModel]
    var stateId: Int?
    var categoryId: Int?
    var isFavorite: Bool? = false // TODO: Make it Not nilable later
    // TODO: Consider saving list of favorites separately from the questions & have a favorites service responsible for managing them e.g. add, update, read, delete
    
    init(id: Int, title: String, image: UIImage? = nil, answers: [AnswerModel], stateId: Int? = nil, categoryId: Int? = nil, isFavorite: Bool? = nil) {
        self.id = id
        self.title = title
        self.image = image
        self.answers = answers
        self.stateId = stateId
        self.categoryId = categoryId
        self.isFavorite = isFavorite
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        answers = try container.decode([AnswerModel].self, forKey: .answers)
        stateId = try container.decodeIfPresent(Int.self, forKey: .stateId)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite)
        
        if let imageB64 = try container.decodeIfPresent(String.self, forKey: .image) {
            if let data = Data(base64Encoded: imageB64) {
                image = UIImage(data: data)
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let image = image, let data = image.pngData() {
            try container.encode(data, forKey: .image)
        }
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(answers, forKey: .answers)
        try container.encodeIfPresent(stateId, forKey: .stateId)
        try container.encodeIfPresent(categoryId, forKey: .categoryId)
        try container.encodeIfPresent(isFavorite, forKey: .isFavorite)
        
    }

    var correctAnswer: AnswerModel? {
        answers.first(where: { $0.isCorrect })
    }

    static let `none` = QuestionModel(id: 0, title: "", image: nil, answers: [], stateId: nil, categoryId: nil, isFavorite: false)
    
    func makeCopy() -> QuestionModel {
        QuestionModel(id: id, title: title, image: image, answers: answers, stateId: stateId, categoryId: categoryId, isFavorite: isFavorite)
    }
    
    func makeCopyToggledFavorite() -> QuestionModel {
        var value = makeCopy()
        value.isFavorite = !(value.isFavorite ?? false)
        return value
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, image = "imageAsBase64", answers, stateId, categoryId, isFavorite
    }
}
