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
    
    static let eventBookingBtn = LinearGradient(
        colors: [
            Color(red: 215/255, green: 38/255, blue: 56/255),  // #D72638
            Color(red: 255/255, green: 90/255, blue: 95/255) 
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let foodOrderBtn = LinearGradient(
        colors: [
            Color(red: 255/255, green: 130/255, blue: 67/255), 
            Color(red: 255/255, green: 211/255, blue: 145/255)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
