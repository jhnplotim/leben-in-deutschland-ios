//
//  AssessmentView.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 03.03.23.
//

import SwiftUI

struct AssessmentView: View {

    @StateObject var viewModel: AssessmentViewModel
    @Environment(\.dismiss) var dismiss
    var onClose: (() -> Void)?

    enum C {
        static let navigationTitle = "Exam / Assessment"
        
        static let notFavoriteIconName = "heart"
        
        static let favoriteIconName = "heart.fill"

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
                if viewModel.isTimed {
                    withAnimation {
                        Text(viewModel.timeRemaining)
                            .bold()
                            .font(.caption)
                            .onReceive(viewModel.timer) { _ in
                                viewModel.updateTime()
                            }
                    }
                }
                
                CircularProgressView(progress: viewModel.summary.progress, lineWidth: 10)
                    .frame(width: 50, height: 50)
                Text("\(viewModel.summary.questionCount) Questions")
                    .font(.caption)
                    .foregroundColor(.secondary)
                if viewModel.assessmentCompleted {
                    HStack {
                        if viewModel.summary.passed {
                            Text("\(C.formatter.string(from: NSNumber(value: viewModel.summary.score)) ?? "0 %")")
                                .font(.title)
                                .bold()
                                .foregroundColor(.green)
                            Text("PASS")
                                .font(.title)
                                .foregroundColor(.green)
                        } else {
                            Text("\(C.formatter.string(from: NSNumber(value: viewModel.summary.score)) ?? "0 %")")
                                .font(.title)
                                .bold()
                                .foregroundColor(.red)
                            Text("FAIL")
                                .font(.title)
                                .foregroundColor(.red)
                        }

                    }
                }

                getQuestionView(position: viewModel.currentQuestionPosition, question: viewModel.currentAssessmentQuestion)

                HStack {
                    Button {
                        viewModel.loadPreviousQuestion()
                    } label: {
                        Label("Back", systemImage: "arrowshape.backward")
                    }
                    Spacer()
                    Button {
                        viewModel.loadNextQuestion()
                    } label: {
                        Label("Next", systemImage: "arrowshape.forward")
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.assessmentTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.up")
                    }
                    .disabled(viewModel.summary.questionCountUnanswered > 0)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.toggleCurrentAsFavorite()
                    } label: {
                        if  viewModel.currentAssessmentQuestion.question.isFavorite == true {
                            Label("Favorite", systemImage: C.favoriteIconName)
                        } else {
                            Label("Favorite", systemImage: C.notFavoriteIconName)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.initialise()
        }
        .onDisappear {
            viewModel.deInitialise()
            onClose?()
        }
    }

    @ViewBuilder
    private func getQuestionView(position: Int, question: AssessmentQuestion) -> some View {
        QuestionDetail(
            model: .init(curPos: position, qn: question),
            animationSize: 200
        ) { answered in
            viewModel.updateCurrentQuestion(assessmentQuestion: answered)
        }
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .state(stateId: "by"), questionService: QuestionServiceImpl()))
            
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .state(stateId: "by", count: 4), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .state(stateId: "be"), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .state(stateId: "be", count: 4), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .general(count: 3), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .general(count: 6), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .general(), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .exam(stateId: "be", generalCount: 4, stateCount: 2), questionService: QuestionServiceImpl()))
            AssessmentView(viewModel: .init(attemptManager: TestAttemptManagerImpl(), assessmentType: .exam(stateId: "by", generalCount: 4, stateCount: 2), questionService: QuestionServiceImpl()))
        }
    }
}
