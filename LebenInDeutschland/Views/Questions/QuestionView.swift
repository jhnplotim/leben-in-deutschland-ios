//
//  QuestionView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionView: View {
    
    var position: Int
    var question: QuestionModel
    @State private var selectedAnswer: AnswerModel?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(position). \(question.title)")
                .font(.headline)
            
            if let imageLink = question.imageLink {
                AsyncImage(url: imageLink) { image in
                    image
                        .resizable()
                        .frame(height: 250)
                        .aspectRatio(1.75, contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Form {
                Picker(selection: $selectedAnswer) {
                    ForEach(question.answers) { answer in
                        Text(answer.text)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .tag(answer)
                    }
                } label: {

                }.pickerStyle(.inline)
            }
        }
        .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static let index2 = 2
    static let index0 = 0
    static let index3 = 3
    static let index6 = 6
    static let index7 = 7
    
    static var previews: some View {
        Group {
            QuestionView(position: index2 + 1, question: ModelData().allQuestions[index2])
            
            QuestionView(position: index6 + 1, question: ModelData().allStateQuestions[index6])
            
            QuestionView(position: index3 + 1, question: ModelData().generalQuestions[index3])
            
            QuestionView(position: index0 + 1, question: ModelData().selectedStateQuestions[index0])
            
            QuestionView(position: index7 + 1, question: ModelData().selectedStateQuestions[index7])
            
        }
    }
}
