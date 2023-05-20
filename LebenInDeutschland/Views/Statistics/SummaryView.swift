//
//  SummaryView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 07.03.23.
//

import SwiftUI
import Combine

struct SummaryView: View {
    // ViewModel
    @StateObject
    var viewModel: SummaryViewModel
    
    private enum C {
        static let fitText = "Fit for the test"
        static let practiceText = "Practiced atleast once"
        static let lastWrongAnsText = "Last answered incorrectly"
    }
    
    var body: some View {
        NavigationView {
            if viewModel.examCount > 0 || viewModel.questionAttemptCount > 0 {
                GaugeViews(
                    examAttemptCount: viewModel.examCount,
                    answeredQuestionCount: viewModel.questionAttemptCount,
                    items: [
                        // TODO: Use actual data
                        .fitForTest(progress: 0.673),
                        .practicedAtleastOnce(progress: 0.553),
                        .lastAnsweredIncorrectly(progress: 0.1)
                    ])
                .navigationTitle("Summary")
                .navigationBarTitleDisplayMode(.inline)

            } else {
                Text("No attempts so far")
                    .font(.largeTitle)
                    .navigationTitle("Summary")
                    .navigationBarTitleDisplayMode(.large)
            }

        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        // TODO: Use TestAttemptManagerImpl
        SummaryView(viewModel: .init(attemptMgr: TestAttemptManagerImpl()))
    }
}

// TODO: Move to test utilities folder (if present), otherwise, please create it and then move this class there
final class TestAttemptManagerImpl: AttemptManager {
    func getChosenAnswers(for questionId: Int) -> [ChosenAnswer] {
        []
    }
    
    var examState: AnyPublisher<ExamAttemptState, Never> = Just(ExamAttemptState.attempted(exams: [CompletedExam(id: 0, stateId: "", questionCount: 1, questionCountAnsweredCorrectly: 1, questionCountAnsweredWrongly: 1, questionCountUnanswered: 2, dateTimeStarted: Date(), dateTimeEnded: Date())])).eraseToAnyPublisher()
    
    var questionAttemptState: AnyPublisher<QuestionAttemptState, Never> = Just(QuestionAttemptState.attempted(answers: [ChosenAnswer(id: 1, answerId: nil, wasCorrect: nil, questionId: 1, dateTimeAdded: Date(), examId: nil)])).eraseToAnyPublisher()
    
    func saveAttempt(questions: [AssessmentQuestion], for assessment: AssessmentType) -> Bool {
        return true
    }
    
}
