//
//  WelcomeScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct WelcomeScreen: View {
    
    var title: String = AppStrings.welcomeTitle
    var subtitle: String = AppStrings.welcomeSubtitle
    
    var body: some View {
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
                .foregroundColor(Color(red: 0.75, green: 0.12, blue: 0.18))
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
            print("Navigate to next screen")
        }) {
            Text("Experience Now")
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
