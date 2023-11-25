//
//  LaunchScreenView.swift
//  TimFresh_Assignment
//
//  Created by Derrick kim on 11/25/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

    @State private var startAnimation = false

    var body: some View {
        ZStack {
            Color.blue800.ignoresSafeArea()
            LogoMeteorImage()
                .offset(
                    x: startAnimation ? -150 : -110,
                    y: startAnimation ? -200 : -300
                )

            LogoMeteorImage()
                .offset(
                    x: startAnimation ? 40 : 110,
                    y: startAnimation ? -250 : -350
                )

            LogoImageView()
        }
        .onReceive(animationTimer) { timerValue in
            updateAnimation()
        }
        .opacity(startAnimation ? 0 : 1)
    }

    private func LogoImageView() -> some View {
        Image.launchScreenLogo
            .resizable()
            .scaledToFit()
            .frame(width: 192, height: 120)
            .colorMultiply(.white)
            .scaleEffect(startAnimation ? 0 : 1)
    }

    private func LogoMeteorImage() -> some View {
        Image.launchScreenMeteor
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 50)
    }

    private let animationTimer = Timer
        .publish(every: 0.5, on: .current, in: .common)
        .autoconnect()

    private func updateAnimation() {
        switch launchScreenState.state {
        case .start:
            withAnimation(.easeInOut(duration: 0.9)) {
                startAnimation = true
            }
        case .finished:
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