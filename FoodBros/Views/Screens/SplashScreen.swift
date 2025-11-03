
import SwiftUI

struct SplashScreen: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            AppBackgrounds.gradientBackground
            
            VStack(spacing: 30) {
                AppIcons.appLogo()
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
    
    var titleSection: some View {
        VStack(spacing: 6) {
            Text("The Food Bros")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(Color(.primary))

            Text("Quality || Food")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black.opacity(0.5))
        }
    }
}

#Preview {
    SplashScreen()
}
