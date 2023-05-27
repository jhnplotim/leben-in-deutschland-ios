//
//  ContentViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.05.23.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var isFirstRun = true
    
    private var settingsStore: SettingsStore
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(_ settingsStore: some SettingsStore) {
        self.settingsStore = settingsStore
        
        self.settingsStore.selectedResidenceStatePublisher.sink(receiveValue: { [weak self] residenceState in
            if case .noneSelected = residenceState {
                self?.isFirstRun = true
            } else {
                self?.isFirstRun = false
            }
        }).store(in: &cancellables)
    }
}
