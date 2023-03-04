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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(examSession)
        }
    }
}
