//
//  SummaryView2.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 25.05.23.
//

import SwiftUI

// TODO: Refactor and create re-usable UI components
struct SummaryView: View {
    
    enum C {
        static let sectionExamAttempts = "Exam attempt history"
        static let sectionCoverageAndReadiness = "Question Coverage & Readiness"
        static let sectionFailureOverview = "Recent failures"
    }
    
    @StateObject
    var viewModel: SummaryViewModel
    
    var qnListVMFactory: ([Int], String) -> QuestionListViewModel = { qnIds, displayTitle in
        DIResolver.shared.resolve(QuestionListViewModel.self, arguments: qnIds, displayTitle)!
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(C.sectionExamAttempts) {
                    if viewModel.examState.orderedPassOrFails.isEmpty {
                        Text("No exam done so far")
                            .font(.caption)
                    } else {
                        HStack {
                            Spacer()
                            VStack {
                                HistoryDotView(items: viewModel.examState.orderedPassOrFails, count: viewModel.examsToShow)
                                Text("\(viewModel.examState.orderedPassOrFails.count) exam(s) attempted so far")
                                    .font(.caption)
                                    .padding(.top, 5)
                            }
                            Spacer()
                        }
                    }
                }
                
                Section(C.sectionCoverageAndReadiness) {
                    ForEach(viewModel.items) { item in
                        HStack {
                            Spacer()
                            VStack {
                                ZStack {
                                    CircularProgressView(progress: item.progress, displayColor: item.displayColor, lineWidth: 10)
                                        .frame(height: 150)
                                    Text(item.progressText)
                                        .font(.title)
                                        .foregroundColor(item.displayColor)
                                }
                                HStack {
                                    Rectangle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(item.displayColor)
                                    Text(item.title)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .lineLimit(0)
                                }
                            }
                            Spacer()
                        }
                    }
                }
                
                if viewModel.hasFailures {
                    Section(C.sectionFailureOverview) {
                        if viewModel.seenQuestionsPercentage.questionsRecentlyFailedOnce.count > 0 {
                            NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                                viewModel.seenQuestionsPercentage.questionsRecentlyFailedOnce,
                                "Failed Once"
                            ))) {
                                
                                Text("Recently failed once (\(viewModel.seenQuestionsPercentage.questionsRecentlyFailedOnce.count))")
                                    .minimumScaleFactor(0.8)
                            }
                            
                        }
                        
                        if viewModel.seenQuestionsPercentage.questionsRecentlyFailedTwice.count > 0 {
                            NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                                viewModel.seenQuestionsPercentage.questionsRecentlyFailedTwice,
                                "Failed Twice"
                            ))) {
                                
                                Text("Recently failed twice (\(viewModel.seenQuestionsPercentage.questionsRecentlyFailedTwice.count))")
                                    .minimumScaleFactor(0.8)
                            }
                            
                        }
                        
                        if viewModel.seenQuestionsPercentage.questionsRecentlyFailedThrice.count > 0 {
                            NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                                viewModel.seenQuestionsPercentage.questionsRecentlyFailedThrice,
                                "Failed Thrice"
                            ))) {
                                
                                Text("Recently failed thrice (\(viewModel.seenQuestionsPercentage.questionsRecentlyFailedThrice.count))")
                                    .minimumScaleFactor(0.8)
                            }
                        }
                    }
                }
            }.navigationTitle("Summary")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var attemptMgr = TestAttemptManagerImpl()
    static var qnService = QuestionServiceImpl()
    
    static var previews: some View {
        SummaryView(viewModel: .init(attemptMgr: attemptMgr, questionService: qnService)) { qnIds, title in
            QuestionListViewModel(questionService: qnService, attemptManager: attemptMgr, qnIds, displayTitle: title)
        }
    }
}
