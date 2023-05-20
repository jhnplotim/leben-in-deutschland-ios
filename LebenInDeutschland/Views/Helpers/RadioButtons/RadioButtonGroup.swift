//
//  RadioButtonGroup.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 28.02.23.
//

import SwiftUI

struct RadioButtonGroup: View {
    let items: [String]

    // TODO: Pick inspiration from List api
    // TODO: Improve state handling
    // TODO: Handle dark mode
    var selectedId: String = ""

    let callback: (String) -> Void

    var body: some View {
        VStack {
            ForEach(0..<items.count) { index in
                RadioButton(self.items[index], callback: self.radioGroupCallback, selectedID: self.selectedId)
            }
        }
    }

    func radioGroupCallback(id: String) {
        callback(id)
    }
}

struct RadioContentView: View {
    @State var selectedItem = "London"
    var body: some View {
        HStack {
            Text("Example")
                .font(Font.headline)
                .padding()
            RadioButtonGroup(items: ["Rome", "London", "Paris", "Berlin", "New York"], selectedId: selectedItem) { selected in
                print("Selected is: \(selected)")
                selectedItem = selected
            }
        }.padding()
    }
}

struct RadioContentView_Previews: PreviewProvider {
    static var previews: some View {
        RadioContentView()
    }
}

struct RadioContentViewDark_Previews: PreviewProvider {
    static var previews: some View {
        RadioContentView()
            .environment(\.colorScheme, .dark)
    }
}
