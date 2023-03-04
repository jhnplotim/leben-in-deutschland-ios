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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(examSession)
        }
    }
}
