//
//  LoginScreen.swift
//  FoodBros
//
//  Created by Rifluxyss on 11/09/25.
//

import SwiftUI

struct LoginScreen: View {
    @State private var showSignUpScreen: Bool = false
    @State private var showForgotPasswordScreen: Bool = false
    @State private var showChoiceScreen: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    private var isAllFieldsFilled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    backgroundView
                    
                    VStack(spacing: 30) {
                        logoSection
                        titleSection
                        inputFields
                        loginButton
                        bottomLinks
                    }
                    .padding(.horizontal, 30)
                }
            }
        } else {
            // Fallback on earlier versions
            Text("Unsupported iOS Version")
        }
    }
}

private extension LoginScreen {
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
    
    var inputFields: some View {
        VStack(spacing: 20) {
            CustomTextField(
                icon: "envelope.fill",
                placeholder: "Email",
                text: $email,
                keyboardType: .emailAddress
            )
            
            CustomSecureField(
                icon: "lock.fill",
                placeholder: "Password",
                text: $password
            )
        }
    }
    
    var loginButton: some View {
        Button(action: {
            showChoiceScreen = true
        }) {
            Text("LOGIN")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isAllFieldsFilled ? Color.red.opacity(0.5) : Color.red)
                .cornerRadius(10)
        }
        .disabled(isAllFieldsFilled)
    }
    
    var bottomLinks: some View {
        HStack {
            Button("Forgot password?") {
                showForgotPasswordScreen = true
            }
            .foregroundColor(.white.opacity(0.8))
            .font(.footnote)
            
            Spacer()
            
            Button("Sign up") {
                showSignUpScreen = true
            }
            .foregroundColor(.white.opacity(0.8))
            .font(.footnote)
            
            NavigationLink(
                destination: SignUpScreen(),
                isActive: $showSignUpScreen
            ) {
                EmptyView()
            }
            .hidden()
            .navigationBarBackButtonHidden()
            
            NavigationLink(
                destination: ForgotPasswordScreen(),
                isActive: $showForgotPasswordScreen
            ) {
                EmptyView()
            }
            .hidden()
            .navigationBarBackButtonHidden()
            
            NavigationLink(
                destination: ChoiceScreen(),
                isActive: $showChoiceScreen
            ) {
                EmptyView()
            }
            .hidden()
            .navigationBarBackButtonHidden()
        }
        .padding(.horizontal)
    }
}


#Preview {
    LoginScreen()
}
