//
//  GaugeViews.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 20.03.23.
//

import SwiftUI

struct GaugeViews: View {
    var examHistory: [Bool]
    var items: [GaugeType]
    var failedOnce: [Int]
    var failedTwice: [Int]
    var failedThrice: [Int]
    var examsToShow = 10
    
    var qnListVMFactory: ([Int], String) -> QuestionListViewModel = { qnIds, displayTitle in
        DIResolver.shared.resolve(QuestionListViewModel.self, arguments: qnIds, displayTitle)!
    }

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
                
                if !failedOnce.isEmpty || !failedTwice.isEmpty || !failedThrice.isEmpty {
                    Text("Failure overview")
                        .font(.title)
                        .padding(.bottom, 5)
                }
                
                VStack {
                    if failedOnce.count > 0 {
                        NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                            failedOnce,
                            "Failed Once"
                        ))) {
                            
                            Text("Recently failed once (\(failedOnce.count))")
                                .minimumScaleFactor(0.8)
                        }
                        
                    }
                    
                    if failedTwice.count > 0 {
                        NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                            failedTwice,
                            "Failed Twice"
                        ))) {
                            
                            Text("Recently failed twice (\(failedTwice.count))")
                                .minimumScaleFactor(0.8)
                        }
                        
                    }
                    
                    if failedThrice.count > 0 {
                        NavigationLink(destination: QuestionListView(viewModel: qnListVMFactory(
                            failedThrice,
                            "Failed Thrice"
                        ))) {
                            
                            Text("Recently failed thrice (\(failedThrice.count))")
                                .minimumScaleFactor(0.8)
                        }
                    }
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
