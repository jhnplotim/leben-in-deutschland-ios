//
//  SettingsView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 17.03.23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
	
	@State private var isPresentingConfirmReset = false
    
    // TODO: Add FirebaseAnalytics to only important events
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
                    HStack {
                        Button(role: .destructive) {
							isPresentingConfirmReset = true
                        } label: {
							Label("Reset app", systemImage: "xmark.bin")
                        }
						.confirmationDialog("Are you sure?",
											 isPresented: $isPresentingConfirmReset) {
			Button("Reset all app activity?", role: .destructive) { 				viewModel.resetApp()
			}
		  } message: {
			Text("You cannot undo this action")
		  }
                    }
                }
                Section {
                    Button {
                        viewModel.rateApp()
                    } label: {
                        Label("Rate", systemImage: "star")
                    }
                    
                    ShareLink(viewModel.shareObject.0, item: viewModel.shareObject.2, message: Text(viewModel.shareObject.1))
                    
                    Button {
                        // TODO: Implement open source licenses
                    } label: {
                        Label("Open Source Licenses", systemImage: "scroll")
                    }
                    
                    Button {
                        // TODO: Implement sending email
                    } label: {
                        Label("Contact", systemImage: "envelope")
                    }
                } header: {
                    Text("About")
                } footer: {
                    Text("version: \(AppVersionProvider.currentAppVersion)")
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var settingsStore = SettingsStoreImpl()
    
    static var reviewService = ReviewServiceImpl()
    
    static var previews: some View {
        SettingsView(viewModel: .init(settingsStore, reviewService))
    }
}
