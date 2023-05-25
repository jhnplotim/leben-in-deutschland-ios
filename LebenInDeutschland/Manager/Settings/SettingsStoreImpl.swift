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
    
}
