//
//  QuestionHistoryView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 07.03.23.
//

import SwiftUI

struct QuestionHistoryView: View {
    var chosenAnswers: [ChosenAnswer]
    var count: Int = 5
    
    init(chosenAnswers: [ChosenAnswer], count: Int = 5) {
        self.chosenAnswers = chosenAnswers.sorted{ $0.dateTimeAdded > $1.dateTimeAdded }
        self.count = count
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            ForEach(0..<count) { i in
                if i < chosenAnswers.count {
                    if let wasCorrect = chosenAnswers[i].wasCorrect {
                        if wasCorrect {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.red)
                        }
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
            QuestionHistoryView(chosenAnswers: [])
            QuestionHistoryView(
                chosenAnswers: [
                    ChosenAnswer(id: 1, answerId: "1", wasCorrect: true, questionId: "1", dateTimeAdded: Date(), examId: nil),
                    ChosenAnswer(id: 2, answerId: "1", wasCorrect: false, questionId: "1", dateTimeAdded: Date(), examId: nil),
                    ChosenAnswer(id: 3, answerId: "1", wasCorrect: false, questionId: "1", dateTimeAdded: Date(), examId: nil),
                    ChosenAnswer(id: 4, answerId: "1", wasCorrect: true, questionId: "1", dateTimeAdded: Date(), examId: nil),
                    ChosenAnswer(id: 5, answerId: "1", wasCorrect: true, questionId: "1", dateTimeAdded: Date(), examId: nil),
                ]
            )
            QuestionHistoryView(
                chosenAnswers: [
                    ChosenAnswer(id: 1, answerId: "1", wasCorrect: false, questionId: "1", dateTimeAdded: Date(), examId: nil),
                    ChosenAnswer(id: 2, answerId: "1", wasCorrect: false, questionId: "1", dateTimeAdded: Date(), examId: nil),
                    ChosenAnswer(id: 3, answerId: "1", wasCorrect: true, questionId: "1", dateTimeAdded: Date(), examId: nil),
                ])
            QuestionHistoryView(chosenAnswers: [
                ChosenAnswer(id: 1, answerId: nil, wasCorrect: nil, questionId: "1", dateTimeAdded: Date(), examId: nil),
                ChosenAnswer(id: 2, answerId: nil, wasCorrect: nil, questionId: "1", dateTimeAdded: Date(), examId: nil),
                ChosenAnswer(id: 3, answerId: "1", wasCorrect: true, questionId: "1", dateTimeAdded: Date(), examId: nil),
            
            ])
        }
    }
}
