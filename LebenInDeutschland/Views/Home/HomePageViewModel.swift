//
//  HomePageViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 23.05.23.
//

import Foundation
import Combine

final class HomePageViewModel: ObservableObject {
    // TODO: Have option to choose state / also maintain an enum
    @Published var currentState: StateModel = .init(id: "be", name: "Berlin", info: "Hauptstadt")
    
    @Published var assessmentToShow: AssessmentType?
    
    @Published var favorites: [Int] = []
    
    @Published var generalQuestions: [Int] = []
    
    @Published var stateQuestions: [Int] = []
    
    // TODO: Use different model
    @Published var categories: [CategoryModel] = []
    
    private var categoryService: CategoryService
    private var questionService: QuestionService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ categoryService: CategoryService, _ questionService: QuestionService) {
        self.categoryService = categoryService
        self.questionService = questionService
        
        // Listen for changes in favorites
        self.questionService.favoritesPublisher.sink(receiveValue: { [weak self] _favorites in
            self?.favorites = _favorites.map { $0.id }
        }).store(in: &cancellables)
        
        // TODO: Listen for any state changes & update questions too.
        
    }
    
    func loadData() {
        // Categories
        categories = categoryService.getCategories().map { cat in
            cat.update(with: questionService.getCategoryQuestions(for: cat.id).map { $0.id })
        }
        
        // all general questions
        generalQuestions = questionService.getAllGeneralQuestions().map { $0.id }
        
        // TODO: Use a publisher since the current state can be changed by the user in settings
        stateQuestions = questionService.getStateQuestions(for: currentState.id).map { $0.id }
        
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
