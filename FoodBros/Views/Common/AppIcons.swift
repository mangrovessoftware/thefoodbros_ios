//
//  AppIcons.swift
//  FoodBros
//
//  Created by Muthu on 03/11/25.
//

import Foundation
import SwiftUI

struct AppIcons {
    static func appLogo(size: CGFloat = 150) -> some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
