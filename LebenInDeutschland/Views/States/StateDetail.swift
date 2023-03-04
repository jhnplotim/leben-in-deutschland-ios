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
        static let examIconName = "envelope.open"
    }
    var state: StateModel
    @State private var showExam: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(state.name).bold()
                
                Button {
                    showExam.toggle()
                } label: {
                    Label("Start exam", systemImage: C.examIconName)
                }
            }.sheet(isPresented: $showExam) {
                ExamView()
            }
        }
    }
}

struct StateDetail_Previews: PreviewProvider {
    static var previews: some View {
        StateDetail(state: ModelData().states[0])
            .environmentObject(ExamManager())
    }
}
