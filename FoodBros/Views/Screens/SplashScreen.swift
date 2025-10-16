//
//  SplashScreen.swift
//  FoodBros
//
//  Created by Rifluxyss on 12/09/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var showLoginScreen: Bool = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
            
                    backgroundView
                    
                    VStack(spacing: 30) {
                        logoSection
                        titleSection
                    }
                    
                    // Hidden navigation link
                    NavigationLink("", destination: LoginScreen(), isActive: $showLoginScreen)
                        .hidden()
                }
                .onAppear {
                    // Navigate after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showLoginScreen = true
                    }
                }
            }
        }
    }
}
extension SplashScreen {
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
    
    var titleSection: some View {
        VStack(spacing: 5) {
            Text("The Food Bros")
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(.white)
            
            Text("Quality || Food")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

#Preview {
    SplashScreen()
}
