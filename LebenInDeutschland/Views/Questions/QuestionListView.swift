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
                if !viewModel.questions.isEmpty {
                    AssessmentRow(title: "Practice") {
                        viewModel.showPractice("Practice")
                    }
                }
                
                ForEach(viewModel.questions) { qnRowModel in
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
        }
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var attemptMgr = AttemptManagerImpl()
    static var questionSrvc = QuestionServiceImpl()
    
    static var previews: some View {
        QuestionListView(viewModel: .init(questionService: questionSrvc, attemptManager: attemptMgr, [1, 2])) { assType in
            AssessmentViewModel(attemptManager: attemptMgr, assessmentType: assType, questionService: questionSrvc)
            
        }
    }
}
