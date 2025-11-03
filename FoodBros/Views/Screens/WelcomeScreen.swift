//
//  WelcomeScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var toShowEventChoiceScreen: Bool = false
    
    var title: String = AppStrings.welcomeTitle
    var subtitle: String = AppStrings.welcomeSubtitle
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    AppBackgrounds.gradientBackground
                    
                    VStack(spacing: 40) {
                        Spacer()
                        
                        AppIcons.appLogo()
                        
                        welcomeTextSection
                        
                        Spacer()
                        
                        AppButtons.primary(type: .bookYourEvent) {
                            toShowEventChoiceScreen = true
                        }
                        
                        Spacer()
                    }
                }
                .background(
                    NavigationLink(
                        destination: ChoiceScreen(),
                        isActive: $toShowEventChoiceScreen
                    ) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
        }
    }
}

extension WelcomeScreen {
    
    var welcomeTextSection: some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(Color(.primary))
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
            
            Text(subtitle)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black.opacity(0.75))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
