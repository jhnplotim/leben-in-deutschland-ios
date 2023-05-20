//
//  QuestionView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionView: View {
    
    @Namespace var imageID
    
    // ViewModel
    var viewModel: QuestionViewModel
    
    var animationSize: CGFloat = 250
    
    var onAnswer: (AssessmentQuestion) -> Void

    enum C {
        static let CORRECT_ANIMATION = "correct_animation"
        static let WRONG_ANIMATION = "wrong_animation"
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    QuestionHistoryView(chosenAnswers: viewModel.getChosenAnswers())
                    Text("\(viewModel.position). \(viewModel.assessmentQuestion.question.title)")
                        .font(.headline)

                    if let imageLink = viewModel.assessmentQuestion.question.imageLink {
                        AsyncImage(url: imageLink) { image in
                            image
                                .resizable()
                                .frame(height: 250)
                                .aspectRatio(1.75, contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    // TODO: Use ID instead of text value to compare
                    RadioButtonGroup(
                        items: viewModel.assessmentQuestion.question.answers.map({$0.text}),
                        selectedId: viewModel.assessmentQuestion.selectedAnswer.text) { selected in
                            // TODO: Move this logic out of view and move it into ViewModel in charge of parent view
                            print("Selected is: \(selected)")
                            var assessmentQuestionNew = viewModel.assessmentQuestion

                            if let correctAns = viewModel.assessmentQuestion.question.correctAnswer, correctAns.text == selected {
                                print("Correct answer selected")
                                assessmentQuestionNew.selectedAnswer = correctAns
                            } else {
                                print("Wrong answer selected")
                                assessmentQuestionNew.selectedAnswer = viewModel.assessmentQuestion.question.answers.first(where: { $0.text == selected}) ?? .none
                            }
                            onAnswer(assessmentQuestionNew)
                        }

                    if viewModel.assessmentQuestion.isAnswered {
                        HStack {
                            Spacer()
                            if viewModel.assessmentQuestion.isCorrectlyAnswered {
                                LottieView(name: C.CORRECT_ANIMATION, loopMode: .playOnce)
                                    .frame(width: animationSize, height: animationSize)
                            } else {
                                LottieView(name: C.WRONG_ANIMATION, loopMode: .playOnce)
                                    .frame(width: animationSize, height: animationSize)
                            }
                            Spacer()
                        }.id(imageID)
                            .onAppear {
                                proxy.scrollTo(imageID)
                            }
                    }

                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    
    static let qns: [QuestionModel] = load("questions.json")
    
    static var qnsUnanswered: [AssessmentQuestion] = qns.map { $0.assessmentQuestionUnanswered }
    static var qnsAnsweredCorrectly: [AssessmentQuestion] = qns.map { $0.assessmentQuestionAnsweredCorrectly}
    static var qnsAnsweredWrongly: [AssessmentQuestion] = qns.map { $0.assessmentQuestionAnsweredWrongly }

    static let index20 = 20
    static let index0 = 0
    static let index3 = 3
    static let index6 = 6
    static let index7 = 7

    static var previews: some View {
        Group {
            QuestionView(viewModel: .init(curPos: index20 + 1, qn: qnsAnsweredWrongly[index20], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
            QuestionView(viewModel: .init(curPos: index20 + 1, qn: qnsAnsweredCorrectly[index20], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
            // TODO: Fix preview with radio button
            QuestionView(viewModel: .init(curPos: index20 + 1, qn: qnsUnanswered[index20], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
            QuestionView(viewModel: .init(curPos: index0 + 1, qn: qnsAnsweredWrongly[index0], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
            QuestionView(viewModel: .init(curPos: index3 + 1, qn: qnsAnsweredCorrectly[index3], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
            QuestionView(viewModel: .init(curPos: index6 + 1, qn: qnsUnanswered[index6], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
            QuestionView(viewModel: .init(curPos: index7 + 1, qn: qnsUnanswered[index7], attMgrFactory: TestAttemptManagerImpl())) { _ in
                
            }
        }
    }
}
