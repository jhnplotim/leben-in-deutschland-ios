//
//  SummaryView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 07.03.23.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var assessmentData: AssessmentManager
    
    var body: some View {
        NavigationView {
            if let examCount = assessmentData.examsDone.count, let answeredCount = assessmentData.chosenAnswers.count, examCount > 0 || answeredCount > 0 {
                ScrollView {
                    VStack(spacing: 20) {
                        Text("\(examCount) exam(s) attempt so far")
                            .font(.body)
                        Text("\(answeredCount) non-unique question(s) attempted  so far")
                            .font(.body)
                    }
                }
                .navigationTitle("Summary")
                .navigationBarTitleDisplayMode(.inline)
                
            } else {
                Text("No question / exam attempts so far")
                    .navigationTitle("Summary")
                    .navigationBarTitleDisplayMode(.large)
            }
            
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
            .environmentObject(AssessmentManager())
    }
}
