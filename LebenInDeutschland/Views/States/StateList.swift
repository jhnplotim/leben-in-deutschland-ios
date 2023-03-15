//
//  StateList.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateList: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.states) { state in
                    NavigationLink {
                        StateDetail(state: state)
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
        StateList()
            .environmentObject(ModelData())
    }
}
