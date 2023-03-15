//
//  PercentageView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 05.03.23.
//

import SwiftUI

struct PercentageView: View {
    let percentage: Double

    init(percentage: Double) {
        let tempPercentage = min(percentage, 100)
        self.percentage = max(tempPercentage, 0)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(percentage)")
            ProgressView(value: percentage, total: 100)
                .tint(.green)
            .background(.red.opacity(0.5))
        }

    }
}

struct PercentageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PercentageView(percentage: 0)
            PercentageView(percentage: 10)
            PercentageView(percentage: 25)
            PercentageView(percentage: 35)
            PercentageView(percentage: 50)
            PercentageView(percentage: 60)
            PercentageView(percentage: 75)
            PercentageView(percentage: 85)
            PercentageView(percentage: 100)
        }
    }
}
