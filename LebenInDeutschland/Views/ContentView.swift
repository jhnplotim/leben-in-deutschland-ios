//
//  ContentView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandingPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ExamManager())
            .environmentObject(ModelData())
    }
}
