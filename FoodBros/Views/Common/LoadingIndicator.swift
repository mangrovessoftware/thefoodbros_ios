//
//  LoadingIndicator.swift
//  FoodBros
//
//  Created by Muthu on 08/11/25.
//

import Foundation
import SwiftUI

struct LoadingIndicator: View {
    @State private var rotate = false
    @State private var currentIconIndex = 0
    @State private var timer: Timer? = nil

    private let eventIcons = [
        "heart.fill",
        "gift.fill",
        "briefcase.fill",
        "diamond.fill",
        "sparkles",
        "sun.max.fill",
        "music.note.list",
        "balloon.2.fill",
        "camera.aperture"
    ]

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [
                                    Color(#colorLiteral(red: 0.84, green: 0.15, blue: 0.22, alpha: 1)),
                                    Color(#colorLiteral(red: 1.0, green: 0.74, blue: 0.76, alpha: 1)),
                                    Color(#colorLiteral(red: 0.84, green: 0.15, blue: 0.22, alpha: 1))
                                ]),
                                center: .center
                            ),
                            lineWidth: 6
                        )
                        .frame(width: 90, height: 90)
                        .rotationEffect(.degrees(rotate ? 360 : 0))
                        .animation(.linear(duration: 1.2).repeatForever(autoreverses: false), value: rotate)
                    
                    Image(systemName: eventIcons[currentIconIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundColor(Color(.primary))
                        .shadow(color: .white.opacity(0.8), radius: 4)
                        .transition(.scale.combined(with: .opacity))
                        .id(currentIconIndex)
                }
            }
            .onAppear {
                rotate = true
                startIconRotation()
            }
            .onDisappear {
                stopIconRotation()
            }
        }
    }

    private func startIconRotation() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.4)) {
                currentIconIndex = (currentIconIndex + 1) % eventIcons.count
            }
        }
    }

    private func stopIconRotation() {
        timer?.invalidate()
        timer = nil
    }
}


