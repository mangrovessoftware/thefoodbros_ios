//
//  AppButtons.swift
//  FoodBros
//
//  Created by Muthu on 03/11/25.
//

import Foundation
import SwiftUI

struct AppButtons {
    enum ButtonType: String {
        case bookYourEvent = "Book Your Event"
        case continueAction = "Continue"
        case learnMore = "Learn More"
        case cancel = "Cancel"
        case submit = "Submit"
        case saveEvent = "Save Event"
    }
    
    static func primary(type: ButtonType, disabled: Bool = true, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(type.rawValue)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.primaryActionBtn)
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                .padding(.horizontal, 40)
        }
        .disabled(disabled)
        .opacity(disabled ? 0.5 : 1.0)
    }
}
