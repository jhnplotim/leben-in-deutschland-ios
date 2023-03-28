//
//  GaugeViews.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 20.03.23.
//

import SwiftUI

struct GaugeViews: View {
    var examAttemptCount: Int
    var answeredQuestionCount: Int
    var items: [GaugeType]

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
                Text("\(examAttemptCount) exam(s) attempt so far")
                    .font(.body)
                Text("\(answeredQuestionCount) non-unique question(s) attempted  so far")
                    .font(.body)
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
            }
            .padding()
        }
        .padding()
    }
}

struct GaugeViews_Previews: PreviewProvider {
    static var previews: some View {
        GaugeViews(examAttemptCount: 3,
                   answeredQuestionCount: 10,
                   items: [.fitForTest(progress: 0.246), .lastAnsweredIncorrectly(progress: 0.557), .practicedAtleastOnce(progress: 0.45)])
    }
}
