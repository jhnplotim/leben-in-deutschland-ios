//
//  FavoritesViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [QuestionModel] = []
    
    private let _questionService: QuestionService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(questionService: some QuestionService) {
        _questionService = questionService
        
        self._questionService.favoritesPublisher.sink(receiveValue: { [weak self] _favorites in
            self?.favorites = _favorites
        }).store(in: &cancellables)
    }
}
