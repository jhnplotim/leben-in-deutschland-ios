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
    
    var selectedState: FederalState { get set }
    
    var selectedStatePublisher: AnyPublisher<FederalState, Never> { get }
}
