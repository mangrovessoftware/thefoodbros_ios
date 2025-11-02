//
//  Colour.swift
//  FoodBros
//
//  Created by Rifluxyss on 10/10/25.
//

import SwiftUI

extension Color {
    static let appThemeGradient = LinearGradient(
        colors: [
            Color(red: 1.0, green: 0.94, blue: 0.92),
            Color(red: 0.99, green: 0.83, blue: 0.80)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let primaryActionBtn = LinearGradient(
        colors: [
            Color(red: 0.84, green: 0.15, blue: 0.22),
            Color(red: 0.6, green: 0.05, blue: 0.1)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
