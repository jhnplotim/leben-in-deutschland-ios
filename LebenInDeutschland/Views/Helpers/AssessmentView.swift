//
//  AssessmentView.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 03.03.23.
//

import SwiftUI

struct AssessmentView: View {
    
    @EnvironmentObject var assessmentData: AssessmentManager
    @Environment(\.dismiss) var dismiss
    
    var assessmentType: AssessmentType
    
    enum C {
        static let navigationTitle = "Exam / Assessment"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(assessmentData.summary.questionCount) Questions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Correct: \(assessmentData.summary.questionCountAnsweredCorrectly) Questions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Wrong: \(assessmentData.summary.questionCountAnsweredWrongly) Questions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Unanswered: \(assessmentData.summary.questionCountUnanswered) Questions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                question
                
                HStack {
                    Button {
                        assessmentData.loadPreviousQuestion()
                    } label: {
                        Label("Back", systemImage: "arrowshape.backward")
                    }
                    Spacer()
                    Button {
                        assessmentData.loadNextQuestion()
                    } label: {
                        Label("Next", systemImage: "arrowshape.forward")
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(C.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.up")
                    }
                    .disabled(assessmentData.summary.questionCountUnanswered > 0)
                    
                }
            }
        }
        .onAppear{
            assessmentData.initialise(for: assessmentType)
        }
        .onDisappear{
            assessmentData.deInitialise()
        }
    }
    
    @ViewBuilder
    private var question: some View {
        QuestionView(
            position: assessmentData.currentQuestionPosition,
            assessmentQuestion: $assessmentData.currentAssessmentQuestion
        )
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssessmentView(assessmentType: .state(stateId: "by"))
            AssessmentView(assessmentType: .state(stateId: "by", count: 4))
            AssessmentView(assessmentType: .state(stateId: "be"))
            AssessmentView(assessmentType: .state(stateId: "be", count: 4))
            AssessmentView(assessmentType: .general(count: 3))
            AssessmentView(assessmentType: .general(count: 6))
            AssessmentView(assessmentType: .general())
            AssessmentView(assessmentType: .exam(stateId: "be", generalCount: 4, stateCount: 2))
            AssessmentView(assessmentType: .exam(stateId: "by", generalCount: 4, stateCount: 2))
        }
        .environmentObject(AssessmentManager())
    }
}
