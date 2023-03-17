//
//  SettingsView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 17.03.23.
//

import SwiftUI

struct SettingsView: View {
    
    // TODO: Create SettingsViewModel / Manager and have all settings in one place
    
    @AppStorage("LebenInDeutschland.vibrateOnFalseAnswer")
    private var vibrateOnFalseAnswer = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Section 1") {
                    Toggle("Vibrate for false answers", isOn: $vibrateOnFalseAnswer)
                    ForEach(0...3, id: \.self) {
                        Text("Item \($0 + 1)")
                    }
                }
                Section("Section 2") {
                    ForEach(0...3, id: \.self) {
                        Text("Item \($0 + 1)")
                    }
                }
                Section("Section 3") {
                    ForEach(0...3, id: \.self) {
                        Text("Item \($0 + 1)")
                    }
                }
                Section("Section 4") {
                    ForEach(0...3, id: \.self) {
                        Text("Item \($0 + 1)")
                    }
                }
                
                Section("Section 5") {
                    ForEach(0...3, id: \.self) {
                        Text("Item \($0 + 1)")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
