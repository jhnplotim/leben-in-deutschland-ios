//
//  GaugeView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 20.03.23.
//

import SwiftUI

struct GaugeView: View {
    var progress: Double = 0.0
    var color: Color = .green
    var textToDisplay: String
    var displayLegend = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Gauge(value: progress, in: 0...1) {
                    Text("%")
                        .foregroundColor(color)
                } currentValueLabel: {
                    Text("\((Int)(progress * 100))")
                        .foregroundColor(color)
                }
                .gaugeStyle(.accessoryCircular)
                .frame(width: min(geometry.size.width, geometry.size.height) * 0.8, height: min(geometry.size.width, geometry.size.height) * 0.8)
                .tint(color)
                
                if displayLegend {
                    HStack {
                        Rectangle()
                            .frame(width: min(geometry.size.width, geometry.size.height) * 0.08, height: min(geometry.size.width, geometry.size.height) * 0.08)
                            .foregroundColor(color)
                        Text(textToDisplay)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(0)
                    }
                    
                }
            }
        }
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GaugeView(
                textToDisplay: "Fit for the test"
            )
                .frame(
                    width: 170,
                height: 350)
            
            GaugeView(textToDisplay: "Fit for the test", displayLegend: false)
                .frame(
                    width: 170,
                height: 350)
            
            GaugeView(
                progress: 0.75,
                color: .orange,
                textToDisplay: "Practiced at least once"
            )
                .frame(
                    width: 170,
                height: 350)
            
            GaugeView(
                progress: 0.4,
                color: .red,
                textToDisplay: "Last answered incorrectly"
            )
                .frame(
                    width: 170,
                height: 350)
        }
    }
}
