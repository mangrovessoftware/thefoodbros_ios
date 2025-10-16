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
            Color(red: 0.0, green: 0.7, blue: 0.7),
            Color(red: 0.0, green: 0.4, blue: 0.6),
            Color(red: 0.0, green: 0.2, blue: 0.3)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
