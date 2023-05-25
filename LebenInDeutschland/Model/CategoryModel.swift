//
//  CategoryModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

struct CategoryModel: Identifiable, Hashable, Codable, Equatable {
    let id: Int
    let name: String
    var qnIds: [Int] = [] // Updated later i.e. not read from JSON / Data source
    
    private enum CodingKeys: String, CodingKey {
            case id, name
        }
    
    init(id: Int, name: String, qnIds: [Int]) {
        self.id = id
        self.name = name
        self.qnIds = qnIds
    }
    
    init(id: Int, name: String) {
        self.init(id: id, name: name, qnIds: [])
    }
}

extension CategoryModel {
    func update(with ids: [Int]) -> CategoryModel {
        .init(id: id, name: name, qnIds: ids)
    }
    
    var nameWithQuestionCount: String {
        "\(name) (\(qnIds.count))"
    }
}
