//
//  StateList.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateList: View {
    @StateObject var viewModel: StateListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.states) { state in
                    Button {
                        viewModel.stateClicked(state: state.federalState)
                    } label: {
                        StateRow(state: state)
                    }
                }
            }
            .navigationTitle("Where do you live?")
        }
    }
}

struct StateList_Previews: PreviewProvider {
    static var settingsStore = SettingsStoreImpl()
    
    static var previews: some View {
        StateList(viewModel: .init(StateListServiceImpl(), settingsStore))
    }
}
