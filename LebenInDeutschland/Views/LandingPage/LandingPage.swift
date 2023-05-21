//
//  LandingPage.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI

struct LandingPage: View {

    @State private var selection: Tab = .states
    
    var categoryListVMFactory: () -> CategoryListViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(CategoryListViewModel.self)!
    }
    
    var summaryVMFactory: () -> SummaryViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(SummaryViewModel.self)!
    }
    
    var stateListVMFactory: () -> StateListViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(StateListViewModel.self)!
    }
    
    var favoritesVMFactory: () -> FavoritesViewModel = {
        // swiftlint:disable force_unwrapping
        DIResolver.shared.resolve(FavoritesViewModel.self)!
    }

    enum Tab {
        case states
        case summary
        case categories
        case settings
        case favorites
    }
    enum C {
        // TODO: Replace icons with more representative ones
        static let statesIconName = "list.bullet"
        static let summaryIconName = "note"
        static let categoryIconName = "square.stack"
        static let settingsIconName = "seal"
        static let favoritesIconName = "heart.fill"
    }

    var body: some View {
        TabView(selection: $selection) {
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

            CategoryList(viewModel: categoryListVMFactory())
                .tabItem {
                    Label("Categories", systemImage: C.categoryIconName)
                }
                .tag(Tab.categories)

            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: C.settingsIconName)
                }
                .tag(Tab.settings)
            FavoritesView(viewModel: favoritesVMFactory())
                .tabItem {
                    Label("Favorites", systemImage: C.favoritesIconName)
                }

        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage() {
            // Pass in test implementation of ViewModel if needed
            CategoryListViewModel(CategoryServiceImpl())
        } summaryVMFactory: {
            SummaryViewModel(attemptMgr: TestAttemptManagerImpl(), questionService: QuestionServiceImpl())
        } stateListVMFactory: {
            StateListViewModel(StateListServiceImpl())
        } favoritesVMFactory: {
            FavoritesViewModel(questionService: QuestionServiceImpl())
        }
    }
}
