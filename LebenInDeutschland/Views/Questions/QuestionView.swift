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
    
    @State private var correctAnswerSelected: Bool? = nil
    
    enum C {
        static let CORRECT_ANIMATION = "correct_animation"
        static let WRONG_ANIMATION = "wrong_animation"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
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
            
            // TODO: Use ID instead of text value to compare
            RadioButtonGroup(items: question.answers.map({$0.text}), selectedId: "") { selected in
                print("Selected is: \(selected)")
                if let correctAns = question.correctAnswer, correctAns.text == selected {
                    print("Correct answer selected")
                    correctAnswerSelected = true
                } else {
                    print("Wrong answer selected")
                    correctAnswerSelected = false
                }
                
            }
            
            if let correctAnswerSelected {
                HStack {
                    Spacer()
                    if correctAnswerSelected {
                        LottieView(name:  C.CORRECT_ANIMATION , loopMode: .playOnce)
                            .frame(width: 250, height: 250)
                    } else {
                        LottieView(name: C.WRONG_ANIMATION , loopMode: .playOnce)
                            .frame(width: 250, height: 250)
                    }
                    Spacer()
                }
            }
            
            
            Spacer()
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
