//
//  SettingsViewModel.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    @Published var vibrateOnWrongAnswer = false
    
    @Published var selectedState: FederalState
    
    private var _settingsStore: SettingsStore
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(_ settingsStore: SettingsStore) {
        self._settingsStore = settingsStore
        self.vibrateOnWrongAnswer = self._settingsStore.vibrateOnFalseAnswer
        self.selectedState = self._settingsStore.selectedState
        
        $vibrateOnWrongAnswer.sink(receiveValue: { newValue in
            if self._settingsStore.vibrateOnFalseAnswer != newValue {
                self._settingsStore.vibrateOnFalseAnswer = newValue
            }
        }).store(in: &cancellables)
        
        $selectedState.sink(receiveValue: { newValue in
                if self._settingsStore.selectedState != newValue {
                    self._settingsStore.selectedState = newValue
                }
        }).store(in: &cancellables)
    }
    
}
