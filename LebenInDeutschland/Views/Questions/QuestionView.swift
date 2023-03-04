//
//  QuestionView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionView: View {
    
    typealias SelectedAnswerCallback = (QuestionModel, AnswerModel) -> Void
    
    var position: Int
    @Binding var examQuestion: ExamQuestion
    
    @EnvironmentObject var examData: ExamManager
    
    enum C {
        static let CORRECT_ANIMATION = "correct_animation"
        static let WRONG_ANIMATION = "wrong_animation"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("\(position). \(examQuestion.question.title)")
                .font(.headline)
            
            if let imageLink = examQuestion.question.imageLink {
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
                items: examQuestion.question.answers.map({$0.text}),
                selectedId: examQuestion.selectedAnswer.text) { selected in
                    print("Selected is: \(selected)")
                    var examQuestionNew = examQuestion
                    
                    if let correctAns = examQuestion.question.correctAnswer, correctAns.text == selected {
                        print("Correct answer selected")
                        examQuestionNew.selectedAnswer = correctAns
                    } else {
                        print("Wrong answer selected")
                        examQuestionNew.selectedAnswer = examQuestion.question.answers.first(where: { $0.text == selected}) ?? .none
                    }
                    examData.updateCurrentQuestion(examQuestion: examQuestionNew)
                }
            
            if examQuestion.isAnswered {
                HStack {
                    Spacer()
                    if examQuestion.isCorrectlyAnswered {
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
    static let examSession: ExamManager = ExamManager()
    
    static let index2 = 2
    static let index0 = 0
    static let index3 = 3
    static let index6 = 6
    static let index7 = 7
    
    static var previews: some View {
        Group {
            QuestionView(
                position: index2 + 1,
                examQuestion: .constant(examSession.examQuestions?[index2] ?? .none))
                .environmentObject(examSession)
            
            QuestionView(
                position: index6 + 1,
                examQuestion: .constant(ModelData().allStateQuestions[index6].examQuestionAnsweredWrongly))
            
            QuestionView(
                position: index3 + 1,
                examQuestion: .constant(ModelData().generalQuestions[index3].examQuestionAnsweredCorrectly))
            
            QuestionView(
                position: index0 + 1,
                examQuestion: .constant(ModelData().selectedStateQuestions[index0].examQuestionUnanswered))
            
            QuestionView(
                position: index7 + 1,
                examQuestion: .constant(ModelData().selectedStateQuestions[index7].examQuestionUnanswered))
            
        }
    }
}
