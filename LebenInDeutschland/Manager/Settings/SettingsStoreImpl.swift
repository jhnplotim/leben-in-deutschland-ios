//
//  SettingsStoreImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import SwiftUI
import Combine
import Swinject

final class SettingsStoreImpl: SettingsStore {
    
    @AppStorage("LebenInDeutschland.vibrateOnFalseAnswer")
    var vibrateOnFalseAnswer = false
    
    // TODO: Make default value, none
    @PublishableAppStorage("LebenInDeutschland.residenceState", defaultValue: FederalState.noneSelected)
    var stateOfResidence: FederalState
    
    // MARK: - Publishers
    lazy var selectedResidenceStatePublisher: AnyPublisher<FederalState, Never> = self._stateOfResidence.publisher.eraseToAnyPublisher()
	
	/// Clear contents of the app and navigate to the residence state selection page
	func resetApp() {
		// Clear all UserDefaults
		UserDefaults.standard.clear()
		
		// Reset all settings here
		stateOfResidence = .noneSelected
		vibrateOnFalseAnswer = false
		
		// Clear DI singleton scope
		Assembler.container.resetObjectScope(.customSingleton)
	}
}
