//
//  CategoryDetailViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 15.05.23.
//

import Foundation

final class CategoryDetailViewModel: ObservableObject {
    let category: CategoryModel
    @Published var questions: [QuestionModel]
    
    init(category: CategoryModel, _ service: QuestionService = QuestionServiceImpl()) {
        self.category = category
        self.questions = service.getQuestions(for: category.id)
    }
    
}
