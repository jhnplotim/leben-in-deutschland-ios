//
//  HomePageViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 23.05.23.
//

import Foundation
import Combine

final class HomePageViewModel: ObservableObject {
    // TODO: Change to FederalState enum
    @Published var currentState: StateModel = .init(id: "be", name: "Berlin", info: "Hauptstadt")
    
    @Published var assessmentToShow: AssessmentType?
    
    @Published var favorites: [Int] = []
    
    @Published var generalQuestions: [Int] = []
    
    @Published var stateQuestions: [Int] = []
    
    // TODO: Use different model
    @Published var categories: [CategoryModel] = []
    
    private var categoryService: CategoryService
    private var questionService: QuestionService
    private var settingsStore: SettingsStore
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ categoryService: some CategoryService, _ questionService: some QuestionService, _ settingsStore: some SettingsStore) {
        self.categoryService = categoryService
        self.questionService = questionService
        self.settingsStore = settingsStore
        
        Publishers.CombineLatest(self.questionService.favoritesPublisher, self.settingsStore.selectedResidenceStatePublisher).sink(receiveValue: { [weak self] favs, residenceState in
            
            self?.favorites = favs.filter { $0.stateId == nil || $0.stateId == residenceState.id }.map { $0.id }
            self?.currentState = residenceState.dataModel
            self?.stateQuestions = self?.questionService.getStateQuestions(for: residenceState.id).map { $0.id } ?? []
            
        }).store(in: &cancellables)
        
    }
    
    func loadData() {
        // Categories
        categories = categoryService.getCategories().map { cat in
            cat.update(with: questionService.getCategoryQuestions(for: cat.id).map { $0.id })
        }
        
        // all general questions
        generalQuestions = questionService.getAllGeneralQuestions().map { $0.id }
        
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
