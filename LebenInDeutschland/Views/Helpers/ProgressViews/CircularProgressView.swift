//
//  CircularProgressView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 11.03.23.
//

import SwiftUI

struct CircularProgressView: View {

    let progress: Double
    
    var displayColor: Color = .green

    var lineWidth: CGFloat = 30

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    displayColor.opacity(0.5),
                    lineWidth: lineWidth
            )

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    displayColor,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)

        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircularProgressView(progress: 0.25, lineWidth: 5)
                .frame(width: 50, height: 50)

            CircularProgressView(progress: 0.5)
                .frame(width: 200, height: 200)

            CircularProgressView(progress: 0.8)
                .frame(width: 200, height: 200)

            CircularProgressView(progress: 1)
                .frame(width: 200, height: 200)
        }
    }
}
