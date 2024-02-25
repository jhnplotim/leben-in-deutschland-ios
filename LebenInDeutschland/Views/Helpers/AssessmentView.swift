//
//  AssessmentView.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 03.03.23.
//

import SwiftUI
import FirebaseAnalytics

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

                getQuestionView(position: viewModel.currentQuestionPosition, question: viewModel.currentAssessmentQuestion, assessmentComplete: $viewModel.assessmentCompleted,
                    vibrateOnWrongAnswer: $viewModel.vibrateOnWrongAnser)

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
        .analyticsScreen(
            name: "AssessmentView",
            extraParameters: ["title": viewModel.assessmentTitle,
                              "isTimed": viewModel.isTimed,
                              "vibrateOnWrongAnswer": viewModel.vibrateOnWrongAnser,
                              "count": viewModel.questionCount
                             ])
        .onDisappear {
            viewModel.deInitialise()
            onClose?()
        }
    }

    @ViewBuilder
    private func getQuestionView(position: Int, question: AssessmentQuestion, assessmentComplete: Binding<Bool>, vibrateOnWrongAnswer: Binding<Bool>) -> some View {
        QuestionDetail(
            model: .init(curPos: position, qn: question),
            animationSize: 200,
            assessmentComplete: assessmentComplete,
            vibrateOnWrongAnser: vibrateOnWrongAnswer
        ) { answered in
            viewModel.updateCurrentQuestion(assessmentQuestion: answered)
        }
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var attemptMgr = AttemptManagerImpl()
    
    static var questionService = QuestionServiceImpl()
    
    static var settingsStore = SettingsStoreImpl()
    
    static var previews: some View {
        Group {
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                                 assessmentType: .state(stateId: FederalState.bayern.id),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                                 assessmentType: .state(stateId: FederalState.bayern.id, count: 4),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                                 assessmentType: .state(stateId: FederalState.berlin.id),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                                 assessmentType: .state(stateId: FederalState.berlin.id, count: 4),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                assessmentType: .general(count: 3),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                assessmentType: .general(count: 6),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                assessmentType: .general(),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                                 assessmentType: .exam(stateId: FederalState.berlin.id, generalCount: 4, stateCount: 2),
                questionService: questionService,
                settingsStore: settingsStore))
            
            AssessmentView(
                viewModel: .init(attemptManager: attemptMgr,
                                 assessmentType: .exam(stateId: FederalState.bayern.id, generalCount: 4, stateCount: 2),
                questionService: questionService,
                settingsStore: settingsStore))
        }
    }
}
