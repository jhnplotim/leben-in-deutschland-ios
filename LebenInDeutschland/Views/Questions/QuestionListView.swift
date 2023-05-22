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
    
    @State private var assessmentType: AssessmentType?
    
    var assessVMFactory: (AssessmentType) -> AssessmentViewModel = { assType in
        DIResolver.shared.resolve(AssessmentViewModel.self, argument: assType)!
    }
    
    var body: some View {
        
        NavigationView {
            List {
                Button {
                    assessmentType = .questions(qnIds: viewModel.questionIds, title: "Practice")
                } label: {
                    Text("Practice")
                }
                ForEach(viewModel.questions) { qnRowModel in
                    QuestionRow(model: qnRowModel).onTapGesture {
                        assessmentType = .questions(qnIds: [qnRowModel.id], title: "Single")
                    }
                }
            }
            .navigationTitle(viewModel.pageTitle)
            .onAppear(perform: viewModel.fetchQuestions)
            .sheet(item: $assessmentType) { value in
                AssessmentView(viewModel: assessVMFactory(value))
            }
        }
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListView(viewModel: .init(questionService: QuestionServiceImpl(), attemptManager: AttemptManagerImpl(), [1, 2])) { assType in
            AssessmentViewModel(attemptManager: AttemptManagerImpl(), assessmentType: assType, questionService: QuestionServiceImpl())
            
        }
    }
}
