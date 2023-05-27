//
//  LaunchScreenView.swift
//  LebenInDeutschland
//
//  Created by John Paul Otim on 05.03.23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

    @State private var firstAnimation = false
    @State private var secondAnimation = false
    @State private var startFadeoutAnimation = false

    enum C {
        // TODO: Use different icon here
        static let launchScreenIconName = "hurricane"
    }

    @ViewBuilder
    private var image: some View {
        Image(systemName: C.launchScreenIconName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .rotationEffect(firstAnimation ? Angle(degrees: 900) : Angle(degrees: 1800))
            .scaleEffect(secondAnimation ? 0 : 1)
            .offset(y: secondAnimation ? 400 : 0)
            .foregroundColor(.primary)
    }

    @ViewBuilder
    private var backgroundColor: some View {
        Color.accentColor.ignoresSafeArea()
    }

    private let animationTimer = Timer
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            backgroundColor
            image
        }.onReceive(animationTimer) { _ in
            updateAnimation()
        }.opacity(startFadeoutAnimation ? 0 : 1)
    }

    private func updateAnimation() {
        switch launchScreenState.state {

        case .firstStep:
            withAnimation(.easeInOut(duration: 0.9)) {
                firstAnimation.toggle()
            }

        case .secondStep:
            if !secondAnimation {
                withAnimation(.linear) {
                    self.secondAnimation = true
                    startFadeoutAnimation = true
                }
            }

        case .finished:
            // use this case to finish any work needed
            break
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenStateManager())
    }
}
