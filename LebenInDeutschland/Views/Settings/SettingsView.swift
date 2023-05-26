//
//  SettingsView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 17.03.23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section("Options") {
                    Toggle("Vibrate for false answers", isOn: $viewModel.vibrateOnWrongAnswer)
                    Picker("Residence", selection: $viewModel.selectedState) {
                        ForEach(FederalState.allValidCases) { federalState in
                            StateRow(state: federalState.dataModel).tag(federalState)
                        }
                    }
                }
                Section("About") {
                    ForEach(0...1, id: \.self) {
                        Text("Item \($0 + 1)")
                    }
                    Text("Open Source Licenses")
                    Text("Leben in Deutschland v 1.0.0")
                }
                
                Section("About Developer") {
                    Text("Website: TO BE ADDED")
                    Text("JCode Studioz - Germany: CONTACT HERE")
                    
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var settingsStore = SettingsStoreImpl()
    
    static var previews: some View {
        SettingsView(viewModel: .init(settingsStore))
    }
}
