//
//  CategoryDetailViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation
// Cyclic dependencies: https://developer.apple.com/forums/thread/702349
final class CategoryDetailViewModel: ObservableObject {
    let category: CategoryModel
    @Published var questions: [QuestionModel]
    
    init(category: CategoryModel, _ service: QuestionService) {
        self.category = category
        self.questions = service.getQuestions(for: category.id)
    }
    
}
