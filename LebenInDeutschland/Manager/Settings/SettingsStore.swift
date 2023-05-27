//
//  SettingsStore.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import Foundation
import Combine

protocol SettingsStore {
    
    var vibrateOnFalseAnswer: Bool { get set }
    
    var stateOfResidence: FederalState { get set }
    
    var selectedResidenceStatePublisher: AnyPublisher<FederalState, Never> { get }
}
