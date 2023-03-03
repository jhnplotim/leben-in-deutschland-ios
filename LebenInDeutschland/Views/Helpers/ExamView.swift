//
//  ExamView.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 03.03.23.
//

import SwiftUI

struct ExamView: View {
    var questions: [QuestionModel]
    var shouldBeTimed: Bool = false
    
    @State private var currentQuestionIndex = 1
    @State private var selectedAnswers: [QuestionModel : AnswerModel?] = [:]
    // TODO: Wrap in navigation view
    var body: some View {
        VStack {
            Text("Exam")
                .font(.title)
            Text("\(questions.count) Questions")
                .font(.caption)
                .foregroundColor(.secondary)
            
            QuestionView(position: currentQuestionIndex + 1, question: questions[currentQuestionIndex]) { question, answer in
                selectedAnswers[question] = answer
            }
            HStack {
                Button {
                    currentQuestionIndex = max(currentQuestionIndex - 1, 0)
                } label: {
                    Label("Back", systemImage: "arrowshape.backward")
                }
                Spacer()
                Button {
                    currentQuestionIndex = min(currentQuestionIndex + 1, questions.count - 1)
                } label: {
                    Label("Next", systemImage: "arrowshape.forward")
                }
            }
            .padding()
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView(questions: ModelData().allQuestions)
    }
}
