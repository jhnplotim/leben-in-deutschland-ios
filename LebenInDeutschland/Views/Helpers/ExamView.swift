//
//  ExamView.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 03.03.23.
//

import SwiftUI

struct ExamView: View {
    
    @EnvironmentObject var examData: ExamManager
    
    // TODO: Wrap in navigation view
    var body: some View {
        VStack {
            Text("Exam")
                .font(.title)
            Text("\(examData.summary.examQuestionCount) Questions")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Correct: \(examData.summary.questionCountAnsweredCorrectly) Questions")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Wrong: \(examData.summary.questionCountAnsweredWrongly) Questions")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("Unanswered: \(examData.summary.questionCountUnanswered) Questions")
                .font(.caption)
                .foregroundColor(.secondary)
            
            question
            
            HStack {
                Button {
                    examData.loadPreviousQuestion()
                } label: {
                    Label("Back", systemImage: "arrowshape.backward")
                }
                Spacer()
                Button {
                    examData.loadNextQuestion()
                } label: {
                    Label("Next", systemImage: "arrowshape.forward")
                }
            }
            .padding()
        }
    }
    
    var question: some View {
        QuestionView(
            position: examData.currentQuestionPosition,
            examQuestion: $examData.currentExamQuestion
        )
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
            .environmentObject(ExamManager())
    }
}
