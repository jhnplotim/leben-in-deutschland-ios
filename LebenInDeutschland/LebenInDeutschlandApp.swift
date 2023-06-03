//
//  LebenInDeutschlandApp.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI
import Swinject

@main
struct LebenInDeutschlandApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var launchScreenStateMgr = LaunchScreenStateManager()
    
    var contentVMFactory: () -> ContentViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(ContentViewModel.self)!
    }
    
    init() {
        // Initialise DI framework i.e. load all dependencies into assembler
        _ = Assembler.sharedAssembler
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView(viewModel: contentVMFactory())
                
                if launchScreenStateMgr.state != .finished {
                    LaunchScreenView()
                }
                
            }
            .environmentObject(launchScreenStateMgr)
            /*.sheet(item: $modelData.errorWrapper, onDismiss: { // TODO: Re-enable later when handling errors
             // TODO: Do something on dismiss
             }) { wrapper in
             ErrorView(errorWrapper: wrapper)
             }*/
        }
    }
}
