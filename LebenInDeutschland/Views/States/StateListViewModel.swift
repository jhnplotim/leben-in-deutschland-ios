//
//  StateListViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 19.05.23.
//

import Foundation

final class StateListViewModel: ObservableObject {
    @Published var states: [StateModel]
    
    private var settingsStore: SettingsStore
    
    init(_ service: some StateListService, _ settingsStore: some SettingsStore) {
        // Load states from data storage
        self.states = service.getAll()
        self.settingsStore = settingsStore
    }
    
    func stateClicked(state: FederalState) {
        settingsStore.stateOfResidence = state
    }
}
