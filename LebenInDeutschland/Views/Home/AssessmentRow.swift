//
//  AssessmentRow.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 23.05.23.
//

import SwiftUI

struct AssessmentRow: View {
    
    var title: String
    var onClick: () -> Void
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "book")
            }
        }
    }
}

struct AssessmentRow_Previews: PreviewProvider {
    static var previews: some View {
        AssessmentRow(title: "Practice - 30") {
            
        }
        .padding()
    }
}
