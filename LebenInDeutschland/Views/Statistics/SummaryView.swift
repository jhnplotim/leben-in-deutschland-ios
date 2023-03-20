//
//  SummaryView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 07.03.23.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var assessmentData: AssessmentManager
    
    private enum C {
        static let fitText = "Fit for the test"
        static let practiceText = "Practiced atleast once"
        static let lastWrongAnsText = "Last answered incorrectly"
    }

    var body: some View {
        NavigationView {
            if let examCount = assessmentData.examsDone.count, let answeredCount = assessmentData.chosenAnswers.count, examCount > 0 || answeredCount > 0 {
                ScrollView {
                    VStack {
                        Text("\(examCount) exam(s) attempt so far")
                            .font(.body)
                        Text("\(answeredCount) non-unique question(s) attempted  so far")
                            .font(.body)
                        GaugeView(
                            progress: 0.27,
                            color: .green,
                            textToDisplay: C.fitText
                        )
                            .frame(
                                width: 100,
                            height: 200)
                        
                        GaugeView(
                            progress: 0.35,
                            color: .orange,
                            textToDisplay: C.practiceText
                        )
                            .frame(
                                width: 100,
                            height: 200)
                        
                        GaugeView(
                            progress: 0.56,
                            color: .red,
                            textToDisplay: C.lastWrongAnsText
                        )
                            .frame(
                                width: 100,
                            height: 200)
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
