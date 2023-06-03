//
//  LandingPage.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI
import FirebaseAnalyticsSwift

struct LandingPage: View {
    
    @State private var selection: Tab = .home
    
    var summaryVMFactory: () -> SummaryViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(SummaryViewModel.self)!
    }
    
    var homePageVMFactory: () -> HomePageViewModel = {
        DIResolver.shared.resolve(HomePageViewModel.self)!
    }
    
    var settingsVMFactory: () -> SettingsViewModel = {
        DIResolver.shared.resolve(SettingsViewModel.self)!
    }
    
    enum Tab {
        case home
        case summary
        case settings
    }
    enum C {
        static let homeIconName = "house"
        static let summaryIconName = "note"
        static let settingsIconName = "gear"
        
        static let homeTabName = "Home"
        static let summaryTabName = "Summary"
        static let settingsTabName = "Settings"
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomePageView(viewModel: homePageVMFactory())
                .tabItem {
                    Label(C.homeTabName, systemImage: C.homeIconName)
                }
                .tag(Tab.home)
                .analyticsScreen(name: "\(C.homeTabName) Tab") // TODO: Remove later before going live

            SummaryView(viewModel: summaryVMFactory())
                .tabItem {
                    Label(C.summaryTabName, systemImage: C.summaryIconName)
                }
                .tag(Tab.summary)
                .analyticsScreen(name: "\(C.summaryTabName) Tab") // TODO: Remove later before going live
            
            SettingsView(viewModel: settingsVMFactory())
                .tabItem {
                    Label(C.settingsTabName, systemImage: C.settingsIconName)
                }
                .tag(Tab.settings)
                .analyticsScreen(name: "\(C.settingsTabName) Tab") // TODO: Remove later before going live

        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var questionService = QuestionServiceImpl() // Singleton
    
    static var attemptMgr = TestAttemptManagerImpl() // Singleton
    
    static var settingsStore = SettingsStoreImpl() // Singleton
    
    static var reviewService = ReviewServiceImpl() // Singleton
    
    static var previews: some View {
        LandingPage() {
            // Pass in test implementation of ViewModel if needed
            SummaryViewModel(attemptMgr: attemptMgr, questionService: questionService, settingsStore: settingsStore)
        } homePageVMFactory: {
            HomePageViewModel(CategoryServiceImpl(), questionService, settingsStore)
        } settingsVMFactory: {
            SettingsViewModel(settingsStore, reviewService)
        }
    }
}
