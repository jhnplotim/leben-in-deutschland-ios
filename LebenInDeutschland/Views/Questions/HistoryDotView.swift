//
//  QuestionHistoryView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 07.03.23.
//

import SwiftUI

struct HistoryDotView: View {
    var items: [Bool]
    var count: Int = 5

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ForEach(0..<count) { i in
                if i < items.count {
                    if items[i] {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.red)
                    }
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}

struct QuestionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HistoryDotView(items: [])
            HistoryDotView(items: [true, false, false, true, true])
            HistoryDotView(items: [false, false, true])
        }
    }
}
