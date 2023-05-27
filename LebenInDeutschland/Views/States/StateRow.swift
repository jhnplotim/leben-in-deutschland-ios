//
//  StateRow.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateRow: View {

    var state: StateModel

    var body: some View {
        HStack {
            state.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 50)
                .cornerRadius(5)
                .clipped()

            VStack(alignment: .leading) {
                Text(state.name)
                    .bold()

                Text(state.info)
                    .font(.caption)
                    .lineLimit(0)
                    .foregroundColor(.secondary)

            }
        }
    }
}

struct StateRow_Previews: PreviewProvider {
    static var previews: some View {
        StateRow(state: StateModel(id: "be", name: "Berlin", info: "Hauptstadt"))
    }
}
