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
        
        static var formatter: NumberFormatter {
            let fm = NumberFormatter()
            fm.numberStyle = .percent
            fm.minimumIntegerDigits = 1
            fm.maximumIntegerDigits = 3
            fm.maximumFractionDigits = 1
            return fm
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CircularProgressView(progress: assessmentData.summary.progress, lineWidth: 10)
                    .frame(width: 50, height: 50)
                Text("\(assessmentData.summary.questionCount) Questions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                if assessmentData.summary.progress == 1 {
                    HStack {
                        if assessmentData.summary.passed {
                            Text("\(C.formatter.string(from: NSNumber(value: assessmentData.summary.score)) ?? "0 %")")
                                .font(.title)
                                .bold()
                                .foregroundColor(.green)
                            Text("PASS")
                                .font(.title)
                                .foregroundColor(.green)
                        } else {
                            Text("\(C.formatter.string(from: NSNumber(value: assessmentData.summary.score)) ?? "0 %")")
                                .font(.title)
                                .bold()
                                .foregroundColor(.red)
                            Text("FAIL")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                        
                    }
                }
                
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
            assessmentQuestion: $assessmentData.currentAssessmentQuestion,
            animationSize: 200
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
