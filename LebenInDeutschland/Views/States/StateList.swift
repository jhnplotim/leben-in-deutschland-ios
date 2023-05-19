//
//  StateList.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateList: View {
    @StateObject var viewModel: StateListViewModel
    
    // For easier testing of SwiftUI view in preview
    var stateDetailVMFactory: (StateModel) -> StateDetailViewModel = { state in
        DIResolver.shared.resolve(StateDetailViewModel.self, argument: state)!
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.states) { state in
                    NavigationLink {
                        StateDetail(viewModel: stateDetailVMFactory(state))
                    } label: {
                        StateRow(state: state)
                    }
                }
            }
            .navigationTitle("States")
        }
    }
}

struct StateList_Previews: PreviewProvider {
    static var previews: some View {
        StateList(viewModel: .init(StateListServiceImpl())) { state in
            StateDetailViewModel(stateToView: state)
        }
    }
}
