//
//  LebenInDeutschlandApp.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

@main
struct LebenInDeutschlandApp: App {
    
    @StateObject private var examSession = ExamManager()
    @StateObject private var modelData = ModelData()
    @StateObject private var launchScreenStateMgr = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                if launchScreenStateMgr.state != .finished {
                    LaunchScreenView()
                }
                
            }
            .environmentObject(modelData)
            .environmentObject(examSession)
            .environmentObject(launchScreenStateMgr)
            .sheet(item: $modelData.errorWrapper, onDismiss: {
                // TODO: Do something on dis
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
