//
//  LandingPage.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI

struct LandingPage: View {

    @State private var selection: Tab = .home
    
    var summaryVMFactory: () -> SummaryViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(SummaryViewModel.self)!
    }
    
    var stateListVMFactory: () -> StateListViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(StateListViewModel.self)!
    }
    
    var homePageVMFactory: () -> HomePageViewModel = {
        DIResolver.shared.resolve(HomePageViewModel.self)!
    }

    var settingsVMFactory: () -> SettingsViewModel = {
        DIResolver.shared.resolve(SettingsViewModel.self)!
    }
    
    enum Tab {
        case home
        case states
        case summary
        case settings
    }
    enum C {
        // TODO: Replace icons with more representative ones
        static let homeIconName = "house"
        static let statesIconName = "list.bullet"
        static let summaryIconName = "note"
        static let settingsIconName = "gear"
    }

    var body: some View {
        TabView(selection: $selection) {
            HomePageView(viewModel: homePageVMFactory())
                .tabItem {
                    Label("Home", systemImage: C.homeIconName)
                }
                .tag(Tab.home)
            
            StateList(viewModel: stateListVMFactory())
                .tabItem {
                    Label("States", systemImage: C.statesIconName)
                }
                .tag(Tab.states)

            SummaryView(viewModel: summaryVMFactory())
                .tabItem {
                    Label("Summary", systemImage: C.summaryIconName)
                }
                .tag(Tab.summary)

            SettingsView(viewModel: settingsVMFactory())
                .tabItem {
                    Label("Settings", systemImage: C.settingsIconName)
                }
                .tag(Tab.settings)

        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var questionService = QuestionServiceImpl() // Singleton
    
    static var attemptMgr = TestAttemptManagerImpl() // Singleton
    
    static var settingsStore = SettingsStoreImpl() // Singleton
    
    static var previews: some View {
        LandingPage() {
            // Pass in test implementation of ViewModel if needed
            SummaryViewModel(attemptMgr: attemptMgr, questionService: questionService)
        } stateListVMFactory: {
            StateListViewModel(StateListServiceImpl())
        } homePageVMFactory: {
            HomePageViewModel(CategoryServiceImpl(), questionService, settingsStore)
        } settingsVMFactory: {
            SettingsViewModel(settingsStore)
        }
    }
}
