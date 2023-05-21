//
//  GaugeViews.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 20.03.23.
//

import SwiftUI

struct GaugeViews: View {
    var examsToShow = 10
    var examHistory: [Bool]
    var items: [GaugeType]
    var failedOnce: [Int]
    var failedTwice: [Int]
    var failedThrice: [Int]

    static var formatter: NumberFormatter {
        let fm = NumberFormatter()
        fm.numberStyle = .percent
        fm.minimumIntegerDigits = 1
        fm.maximumIntegerDigits = 3
        fm.maximumFractionDigits = 1
        return fm
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            
            ScrollView {
                Text("Exam attempt history")
                    .font(.title)
                    .padding(.bottom, 5)
                if examHistory.isEmpty {
                    Text("No exam done so far")
                        .font(.caption)
                } else {
                    HistoryDotView(items: examHistory, count: examsToShow)
                    Text("\(examHistory.count) exam(s) attempted so far")
                        .font(.caption)
                        .padding(.bottom)
                }
                
                Text("Coverage & Readiness")
                    .font(.title)
                    .padding(.bottom, 5)
                ForEach(items) { item in
                    VStack {
                        ZStack {
                            CircularProgressView(progress: item.progress, displayColor: item.displayColor, lineWidth: 10)
                                .frame(height: 150)
                            Text(item.progressText)
                                .font(.title)
                                .foregroundColor(item.displayColor)
                        }
                        HStack {
                            Rectangle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(item.displayColor)
                            Text(item.title)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .lineLimit(0)
                        }
                    }
                }
                
                Text("Failure overview")
                    .font(.title)
                    .padding(.bottom, 5)
                
                VStack {
                    Text("Recently failed once (\(failedOnce.count))") // TODO: Use actual data
                    Text("Recently failed twice (\(failedTwice.count))") // TODO: Use actual data
                    Text("Recently failed thrice (\(failedThrice.count))") // TODO: Use actual data
                }.font(.body)
            }
            .padding()
        }
        .padding()
    }
}

struct GaugeViews_Previews: PreviewProvider {
    static var previews: some View {
        GaugeViews(examHistory: [false, true, false],
                   items: [.fitForTest(progress: 0.246), .lastAnsweredIncorrectly(progress: 0.557), .practicedAtleastOnce(progress: 0.45)],
        failedOnce: [],
        failedTwice: [],
        failedThrice: [])
    }
}
