
import SwiftUI

struct SplashScreen: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack(spacing: 30) {
                logoSection
                titleSection
            }
            .opacity(isAnimating ? 1 : 0)
            .scaleEffect(isAnimating ? 1 : 0.9)
            .animation(.easeInOut(duration: 0.8), value: isAnimating)
        }
        .onAppear {
            startSplashSequence()
        }
    }
}

extension SplashScreen {
    
    func startSplashSequence() {
        withAnimation {
            isAnimating = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NotificationCenter.default.post(
                name: NotificationIdentifiers.hideSplashScreen,
                object: nil
            )
        }
    }
    
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
