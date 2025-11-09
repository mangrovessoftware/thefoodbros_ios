
import SwiftUI

struct ChoiceScreen: View {
    @State private var animateButtons = false
    @State private var showEventChoiceScreen: Bool = false
    
    var body: some View {
        ZStack {
            AppBackgrounds.gradientBackground
            
            VStack(spacing: 25) {
                AppIcons.appLogo()
                titleSection
                choiceSection
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 100)
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animateButtons = true
            }
        }
    }
}

private extension ChoiceScreen {
    
    var titleSection: some View {
        VStack(spacing: 8) {
            Text("Welcome Machi..! \nWhat’s your plan for today?")
                .font(.system(size: 23, weight: .bold, design: .rounded))
                .foregroundColor(Color(.primary))
                .multilineTextAlignment(.leading)
        }
        .padding()
    }
    
    var choiceSection: some View {
        VStack(spacing: 25) {

            Button(action: {
                showEventChoiceScreen = true
            }) {
                HStack {
                    Image(systemName: "calendar")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Event Booking")
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Color.eventBookingBtn
                )
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 3)
                .scaleEffect(animateButtons ? 1 : 0.8)
                .opacity(animateButtons ? 1 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1), value: animateButtons)
            }
            
            Button(action: {
                print("Meal is Ready tapped")
            }) {
                HStack {
                    Image(systemName: "fork.knife")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Food Order")
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Color.foodOrderBtn
                )
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 3)
                .scaleEffect(animateButtons ? 1 : 0.8)
                .opacity(animateButtons ? 1 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.1), value: animateButtons)
            }
            
            NavigationLink(
                destination: EventChoiceScreen(),
                isActive: $showEventChoiceScreen
            ) {
                EmptyView()
            }
        }
    }
}


#Preview {
    ChoiceScreen()
}
