
import SwiftUI

struct SplashScreen: View {
    @State private var showWelcomeScreen: Bool = false
    
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
                    NavigationLink("", destination: WelcomeScreen(), isActive: $showWelcomeScreen)
                        .hidden()
                }
                .onAppear {
                    // Navigate after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showWelcomeScreen = true
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
        VStack(spacing: 6) {
            Text("The Food Bros")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.black)

            Text("Quality || Food")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black.opacity(0.5))
        }
    }
}

#Preview {
    SplashScreen()
}
