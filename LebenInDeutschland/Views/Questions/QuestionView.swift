//
//  QuestionView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 26.02.23.
//

import SwiftUI

struct QuestionView: View {
    var question: QuestionModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionView(question: ModelData().allQuestions[2])
            
            QuestionView(question: ModelData().allStateQuestions[6])
            
            QuestionView(question: ModelData().generalQuestions[3])
            
            QuestionView(question: ModelData().selectedStateQuestions[3])
            
        }
    }
}
