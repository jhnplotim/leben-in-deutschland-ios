//
//  QuestionRow.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 22.05.23.
//

import SwiftUI

struct QuestionRow: View {
    
    let model: Model
    
    struct Model: Identifiable {
        let id: Int
        let title: String
        let answerHistory: [Bool]
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.body)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .padding(.bottom, 5)
            HistoryDotView(items: model.answerHistory)
        }
    }
}

struct QuestionRow_Previews: PreviewProvider {
    static var previews: some View {
        QuestionRow(model: .init(id: 1, title: "What is the capital of Germany and now I am simply typing random text because I can and I want to see what happens when it gets too long and yet now this part is invisible?", answerHistory: [true, true, true, false, false]))
    }
}
