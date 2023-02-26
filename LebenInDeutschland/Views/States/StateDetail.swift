//
//  StateDetail.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateDetail: View {
    var state: StateModel
    
    var body: some View {
        Text(state.name).bold()
    }
}

struct StateDetail_Previews: PreviewProvider {
    static var previews: some View {
        StateDetail(state: ModelData().states[0])
    }
}
