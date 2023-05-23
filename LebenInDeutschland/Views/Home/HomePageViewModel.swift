//
//  HomePageViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 23.05.23.
//

import Foundation

final class HomePageViewModel: ObservableObject {
    // TODO: Have option to choose state / also maintain an enum
    @Published var currentState: StateModel = .init(id: "be", name: "Berlin", info: "Hauptstadt")
    
    @Published var assessmentToShow: AssessmentType?
    
    // TODO: Use different model
    @Published var categories: [CategoryModel] = []
    
    private var categoryService: CategoryService
    private var questionService: QuestionService
    
    init(_ categoryService: CategoryService, _ questionService: QuestionService) {
        self.categoryService = categoryService
        self.questionService = questionService
    }
    
    func loadData() {
        // Categories
        categories = categoryService.getCategories().map { cat in
            cat.update(with: questionService.getQuestions(for: cat.id).map { $0.id })
        }
    }
    
    func showExamAssessment() {
        #if DEBUG
        assessmentToShow = .exam(stateId: currentState.id, generalCount: 10, stateCount: 2)
        #else
        assessmentToShow = .exam(stateId: state.id)
        #endif
    }
    
    func showPracticeAssessment(_ questionCount: Int = 100) {
        assessmentToShow = .general(count: questionCount)
    }
}
