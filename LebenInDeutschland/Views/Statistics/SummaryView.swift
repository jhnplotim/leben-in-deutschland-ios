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
                GaugeViews(
                    examAttemptCount: examCount,
                    answeredQuestionCount: answeredCount,
                    items: [
                        .fitForTest(progress: 0.673),
                        .practicedAtleastOnce(progress: 0.553),
                        .lastAnsweredIncorrectly(progress: 0.1)
                    ])
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
