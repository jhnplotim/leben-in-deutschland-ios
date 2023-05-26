//
//  HomePageView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 23.05.23.
//

import SwiftUI

struct HomePageView: View {
    enum C {
        static let favoritesIconName = "heart.fill"
        static let navigationTitle = "Home"
    }
    
    @StateObject var viewModel: HomePageViewModel
    
    var assessVMFactory: (AssessmentType) -> AssessmentViewModel = { assType in
        DIResolver.shared.resolve(AssessmentViewModel.self, argument: assType)!
    }
    
    var qnListVMFactory: ([Int], String) -> QuestionListViewModel = { qnIds, displayTitle in
        DIResolver.shared.resolve(QuestionListViewModel.self, arguments: qnIds, displayTitle)!
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Assessments") {
                    AssessmentRow(title: "Exam", onClick: viewModel.showExamAssessment)
                    
                    AssessmentRow(title: "Practice - 30", onClick: { viewModel.showPracticeAssessment(30)})
                    
                    AssessmentRow(title: "Practice - 100", onClick: { viewModel.showPracticeAssessment()})
                }
                
                Section("Questions") {
                    if !viewModel.stateQuestions.isEmpty {
                        NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                            viewModel.stateQuestions,
                            viewModel.currentState.name
                        ))) {
                            Text("\(viewModel.currentState.name) (\(viewModel.stateQuestions.count))")
                                .lineLimit(0)
                            .minimumScaleFactor(0.8)
                        }
                    }
                    
                    if !viewModel.generalQuestions.isEmpty {
                        NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                            viewModel.generalQuestions,
                            "All questions"
                        ))) {
                            Text("All questions (\(viewModel.generalQuestions.count))")
                                .lineLimit(0)
                            .minimumScaleFactor(0.8)
                        }
                    }
                    
                    if !viewModel.favorites.isEmpty {
                        NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                            viewModel.favorites,
                            "Favorites"
                        ))) {
                            HStack {
                                Text("Favorites (\(viewModel.favorites.count))")
                                    .lineLimit(0)
                                .minimumScaleFactor(0.8)
                                Spacer()
                                Image(systemName: C.favoritesIconName)
                            }
                        }
                    }
                }
                
                if !viewModel.categories.isEmpty {
                    Section("Categories") {
                        ForEach(viewModel.categories) { category in
                            
                            NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                                category.qnIds,
                                category.name
                            ))) {
                                
                                Text(category.nameWithQuestionCount)
                                    .lineLimit(0)
                                    .minimumScaleFactor(0.8)
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle(C.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $viewModel.assessmentToShow) { value in
                AssessmentView(viewModel: assessVMFactory(value))
            }
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var qnService = QuestionServiceImpl()
    static var settingsStore = SettingsStoreImpl()
    
    static var previews: some View {
        HomePageView(viewModel: .init(CategoryServiceImpl(), qnService, settingsStore))
    }
}
