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
                    examHistory: viewModel.examState.orderedPassOrFails,
                    items: [
                        .practicedAtleastOnce(progress: viewModel.seenQuestionsPercentage.seenOnce),
                        .practicedAtleastTwice(progress: viewModel.seenQuestionsPercentage.seenTwice),
                        .practicedAtleastThrice(progress: viewModel.seenQuestionsPercentage.seenThrice)
                    ],
                    failedOnce: viewModel.seenQuestionsPercentage.questionsRecentlyFailedOnce,
                    failedTwice: viewModel.seenQuestionsPercentage.questionsRecentlyFailedTwice,
                    failedThrice: viewModel.seenQuestionsPercentage.questionsRecentlyFailedThrice)
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
        SummaryView(viewModel: .init(attemptMgr: TestAttemptManagerImpl(), questionService: QuestionServiceImpl()))
    }
}

// TODO: Move to test utilities folder (if present), otherwise, please create it and then move this class there
final class TestAttemptManagerImpl: AttemptManager {
    func getChosenAnswers(for questionId: Int) -> [ChosenAnswer] {
        []
    }
    
    var examState: AnyPublisher<ExamAttemptState, Never> = Just(ExamAttemptState.attempted(exams: [CompletedExam(id: 0, stateId: "", questionCount: 1, questionCountAnsweredCorrectly: 1, questionCountAnsweredWrongly: 1, questionCountUnanswered: 2, dateTimeStarted: Date(), dateTimeEnded: Date(), passmarkUsed: GlobalC.PASSMARK)])).eraseToAnyPublisher()
    
    var questionAttemptState: AnyPublisher<QuestionAttemptState, Never> = Just(QuestionAttemptState.attempted(answers: [ChosenAnswer(id: 1, answerId: nil, wasCorrect: nil, questionId: 1, dateTimeAdded: Date(), examId: nil)])).eraseToAnyPublisher()
    
    func saveAttempt(questions: [AssessmentQuestion], for assessment: AssessmentType) -> Bool {
        return true
    }
    
}
