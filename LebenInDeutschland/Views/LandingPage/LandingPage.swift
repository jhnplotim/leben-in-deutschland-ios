//
//  LandingPage.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 04.03.23.
//

import SwiftUI

struct LandingPage: View {

    @State private var selection: Tab = .states

    enum Tab {
        case states
        case summary
        case categories
        case settings
    }
    enum C {
        // TODO: Replace icons with more representative ones
        static let statesIconName = "list.bullet"
        static let summaryIconName = "note"
        static let categoryIconName = "square.stack"
        static let settingsIconName = "seal"
    }

    var body: some View {
        TabView(selection: $selection) {
            StateList()
                .tabItem {
                    Label("States", systemImage: C.statesIconName)
                }
                .tag(Tab.states)

            SummaryView()
                .tabItem {
                    Label("Summary", systemImage: C.summaryIconName)
                }
                .tag(Tab.summary)

            CategoryList()
                .tabItem {
                    Label("Categories", systemImage: C.categoryIconName)
                }
                .tag(Tab.categories)

            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: C.settingsIconName)
                }
                .tag(Tab.settings)

        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
            .environmentObject(ModelData())
    }
}
