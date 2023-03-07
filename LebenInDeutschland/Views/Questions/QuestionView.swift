//
//  QuestionView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionView: View {
    
    var position: Int
    @Binding var assessmentQuestion: AssessmentQuestion
    
    @EnvironmentObject var assessmentData: AssessmentManager
    
    enum C {
        static let CORRECT_ANIMATION = "correct_animation"
        static let WRONG_ANIMATION = "wrong_animation"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            QuestionHistoryView(chosenAnswers: assessmentData.chosenAnswers.filter{ $0.questionId == assessmentQuestion.question.id })
            Text("\(position). \(assessmentQuestion.question.title)")
                .font(.headline)
            
            if let imageLink = assessmentQuestion.question.imageLink {
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
                items: assessmentQuestion.question.answers.map({$0.text}),
                selectedId: assessmentQuestion.selectedAnswer.text) { selected in
                    print("Selected is: \(selected)")
                    var assessmentQuestionNew = assessmentQuestion
                    
                    if let correctAns = assessmentQuestion.question.correctAnswer, correctAns.text == selected {
                        print("Correct answer selected")
                        assessmentQuestionNew.selectedAnswer = correctAns
                    } else {
                        print("Wrong answer selected")
                        assessmentQuestionNew.selectedAnswer = assessmentQuestion.question.answers.first(where: { $0.text == selected}) ?? .none
                    }
                    assessmentData.updateCurrentQuestion(assessmentQuestion: assessmentQuestionNew)
                }
            
            if assessmentQuestion.isAnswered {
                HStack {
                    Spacer()
                    if assessmentQuestion.isCorrectlyAnswered {
                        LottieView(name:  C.CORRECT_ANIMATION , loopMode: .playOnce)
                            .frame(width: 250, height: 250)
                    } else {
                        LottieView(name: C.WRONG_ANIMATION , loopMode: .playOnce)
                            .frame(width: 250, height: 250)
                    }
                    Spacer()
                }
            }
            
            
            Spacer()
        }
        .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static let assessmentSession: AssessmentManager = AssessmentManager()
    
    static let index2 = 2
    static let index0 = 0
    static let index3 = 3
    static let index6 = 6
    static let index7 = 7
    
    static var previews: some View {
        Group {
            QuestionView(
                position: index2 + 1,
                assessmentQuestion: .constant(assessmentSession.assessmentQuestions?[index2] ?? .none))
            
            QuestionView(
                position: index6 + 1,
                assessmentQuestion: .constant(ModelData().allStateQuestions[index6].assessmentQuestionAnsweredWrongly))
            
            QuestionView(
                position: index3 + 1,
                assessmentQuestion: .constant(ModelData().generalQuestions[index3].assessmentQuestionAnsweredCorrectly))
            
            QuestionView(
                position: index0 + 1,
                assessmentQuestion: .constant(ModelData().selectedStateQuestions[index0].assessmentQuestionUnanswered))
            
            QuestionView(
                position: index7 + 1,
                assessmentQuestion: .constant(ModelData().selectedStateQuestions[index7].assessmentQuestionUnanswered))
        }
        .environmentObject(assessmentSession)
    }
}
