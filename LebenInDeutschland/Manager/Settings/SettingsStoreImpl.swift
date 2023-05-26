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
    @PublishableAppStorage("LebenInDeutschland.selectedState", defaultValue: FederalState.bayern)
    var selectedState: FederalState
    
    // MARK: - Publishers
    lazy var selectedStatePublisher: AnyPublisher<FederalState, Never> = self._selectedState.publisher.eraseToAnyPublisher()
}
