//
//  QuestionListView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 22.05.23.
//

import SwiftUI

struct QuestionListView: View {
    
    @StateObject
    var viewModel: QuestionListViewModel
    
    var assessVMFactory: (AssessmentType) -> AssessmentViewModel = { assType in
        DIResolver.shared.resolve(AssessmentViewModel.self, argument: assType)!
    }
    
    var body: some View {
        
        NavigationView {
            List {
                if !viewModel.filteredResults.isEmpty {
                    AssessmentRow(title: "Practice all") {
                        viewModel.showPractice("Practice")
                    }
                }
                
                ForEach(viewModel.filteredResults) { qnRowModel in
                    QuestionRow(model: qnRowModel).onTapGesture {
                        viewModel.showPractice("Self", qnId: qnRowModel.id)
                    }
                }
            }
            .navigationTitle(viewModel.pageTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: viewModel.fetchQuestions)
            .sheet(item: $viewModel.assessmentToShow) { value in
                AssessmentView(viewModel: assessVMFactory(value)) {
                    viewModel.fetchQuestions()
                }
            }
        }.searchable(text: $viewModel.searchText, prompt: Text("Search"))
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var attemptMgr = AttemptManagerImpl()
    static var questionSrvc = QuestionServiceImpl()
    static var settingsStore = SettingsStoreImpl()
    
    static var previews: some View {
        QuestionListView(
            viewModel: .init(questionService: questionSrvc, attemptManager: attemptMgr, [1, 2])) { assType in
            AssessmentViewModel(
                attemptManager: attemptMgr,
                assessmentType: assType,
                questionService: questionSrvc,
                settingsStore: settingsStore)
            
        }
    }
}
