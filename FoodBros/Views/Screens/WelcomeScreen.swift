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
                    backgroundView
                    
                    VStack(spacing: 40) {
                        Spacer()
                        
                        logoSection
                        
                        welcomeTextSection
                        
                        Spacer()
                        
                        getStartedButton
                        
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
    
    var backgroundView: some View {
        Color.appThemeGradient
        .edgesIgnoringSafeArea(.all)
    }
    
    var logoSection: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
    
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
    
    var getStartedButton: some View {
        Button(action: {
            toShowEventChoiceScreen = true
        }) {
            Text("Book Your Event")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    Color.primaryActionBtn
                )
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                .padding(.horizontal, 40)
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
