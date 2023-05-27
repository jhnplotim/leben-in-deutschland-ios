//
//  ContentView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var launchScreenStateMgr: LaunchScreenStateManager
    
    @StateObject
    var viewModel: ContentViewModel
    
    var stateListVMFactory: () -> StateListViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(StateListViewModel.self)!
    }

    var body: some View {
        VStack {
            if viewModel.isFirstRun {
                StateList(viewModel: stateListVMFactory())
            } else {
                withAnimation {
                    LandingPage()
                }
            }
        }.task {
                try? await getDataFromApi() // TODO: Replace with proper network access + db access
                try? await Task.sleep(for: Duration.seconds(1)) // TODO: Replace with proper network access + db acces
                self.launchScreenStateMgr.dismiss()
            }
    }

    // TODO: Create network manager and remove this function
    fileprivate func getDataFromApi() async throws {
        // swiftlint:disable force_unwrapping
            let googleURL = URL(string: "https://www.google.com")!
            let (_, response) = try await URLSession.shared.data(from: googleURL)
            print(response as? HTTPURLResponse)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var settingsStore = SettingsStoreImpl()
    
    static var stateListService = StateListServiceImpl()
    
    static var previews: some View {
        ContentView(viewModel: .init(settingsStore)) {
            StateListViewModel(stateListService, settingsStore)
        }.environmentObject(LaunchScreenStateManager())
    }
}
