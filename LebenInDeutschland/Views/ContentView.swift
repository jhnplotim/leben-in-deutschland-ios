//
//  ContentView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var launchScreenStateMgr: LaunchScreenStateManager
    
    var body: some View {
        LandingPage()
            .task {
                try? await getDataFromApi() // TODO: Replace with proper network access + db access
                try? await Task.sleep(for: Duration.seconds(1)) // TODO: Replace with proper network access + db acces
                self.launchScreenStateMgr.dismiss()
            }
    }
    
    // TODO: Create network manager and remove this function
    fileprivate func getDataFromApi() async throws {
            let googleURL = URL(string: "https://www.google.com")!
            let (_,response) = try await URLSession.shared.data(from: googleURL)
            print(response as? HTTPURLResponse)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AssessmentManager())
            .environmentObject(ModelData())
            .environmentObject(LaunchScreenStateManager())
    }
}
