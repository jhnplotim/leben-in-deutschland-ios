//
//  SettingsStoreImpl.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import SwiftUI
import Combine

final class SettingsStoreImpl: SettingsStore {
    
    @AppStorage("LebenInDeutschland.vibrateOnFalseAnswer")
    var vibrateOnFalseAnswer = false
    
    // TODO: Make default value, none
    @PublishableAppStorage("LebenInDeutschland.residenceState", defaultValue: FederalState.noneSelected)
    var stateOfResidence: FederalState
    
    // MARK: - Publishers
    lazy var selectedResidenceStatePublisher: AnyPublisher<FederalState, Never> = self._stateOfResidence.publisher.eraseToAnyPublisher()
}
