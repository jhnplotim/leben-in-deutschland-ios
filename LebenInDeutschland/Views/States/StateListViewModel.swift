//
//  StateListViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

final class StateListViewModel: ObservableObject {
    @Published var states: [StateModel]
    
    init(_ service: some StateListService) {
        // Load states from data storage
        self.states = service.getAll()
    }
}
