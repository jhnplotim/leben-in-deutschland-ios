//
//  StateDetail.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateDetail: View {
    enum C {
        // TODO: Use more appropriate icons
        static let assessmentIconName = "envelope.open"
    }
    var state: StateModel

    @State private var assessmentType: AssessmentType?

    var body: some View {
        NavigationView {
            VStack {
                Text(state.name).bold()

                Button {
                    #if DEBUG
                    assessmentType = .exam(stateId: state.id, generalCount: 10, stateCount: 2)
                    #else
                    assessmentType = .exam(stateId: state.id)
                    #endif
                } label: {
                    Label("Start exam", systemImage: C.assessmentIconName)
                }

                Button {
                    #if DEBUG
                    assessmentType = .state(stateId: state.id, count: 5)
                    #else
                    assessmentType = .state(stateId: state.id)
                    #endif
                } label: {
                    Label("Start State only assessment", systemImage: C.assessmentIconName)
                }
            }.sheet(item: $assessmentType) { assessmentType in
                AssessmentView(assessmentType: assessmentType)
            }
        }
    }
}

struct StateDetail_Previews: PreviewProvider {
    static var previews: some View {
        StateDetail(state: ModelData().states[0])
            .environmentObject(AssessmentManager())
    }
}
