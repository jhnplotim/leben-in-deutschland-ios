//
//  StateDetail.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct StateDetail: View {
    enum C {
        // TODO: Use more appropriate icons
        static let assessmentIconName = "envelope.open"
    }
    
    @StateObject
    var viewModel: StateDetailViewModel
    
    // For easier testing of SwiftUI view in preview
    var assessVMFactory: (AssessmentType) -> AssessmentViewModel = { assType in
        DIResolver.shared.resolve(AssessmentViewModel.self, argument: assType)!
    }

    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.state.name).bold()

                Button {
                    viewModel.showExam()
                } label: {
                    Label("Start exam", systemImage: C.assessmentIconName)
                }

                Button {
                    viewModel.showStateOnlyAssessment()
                } label: {
                    Label("Start State only assessment", systemImage: C.assessmentIconName)
                }
            }.sheet(item: $viewModel.assessmentToShow) { assessmentType in
                AssessmentView(viewModel: assessVMFactory(assessmentType))
            }
        }
    }
}

struct StateDetail_Previews: PreviewProvider {
    static var previews: some View {
        StateDetail(viewModel: .init(stateToView: .init(id: "be", name: "Berlin", info: "Hauptstadt"))) { assType in
            AssessmentViewModel(attemptManager: TestAttemptManagerImpl(), assessmentType: assType, questionService: QuestionServiceImpl())
        }
    }
}
