
import SwiftUI

struct ForgotPasswordScreen: View {
    @State private var phone: String = ""
    @State private var showOTP = false
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack(spacing: 40) {
                headerSection
                formCard
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $showOTP) {
            otpScreen
        }
    }
}

private extension ForgotPasswordScreen {
    
    var backgroundView: some View {
        Color.appThemeGradient
        .edgesIgnoringSafeArea(.all)
    }
    
    var headerSection: some View {
        VStack(spacing: 10) {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
            
            Text("The Food Bros")
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(.white)
        }
        .padding(.top, 60)
    }
    
    var formCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Forgot Password")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("Enter your registered phone number to reset your password.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .fixedSize(horizontal: false, vertical: true)
            
            CustomTextField(
                icon: "phone.fill",
                placeholder: "Phone Number",
                text: $phone,
                keyboardType: .phonePad
            )
            
            sendOtpButton
                .padding(.top, 10)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 30)
        .background(Color.black.opacity(0.6))
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.6), radius: 12, x: 0, y: 8)
    }
    
    var sendOtpButton: some View {
        Button(action: {
            withAnimation {
                showOTP = true
            }
        }) {
            Text("Send OTP")
                .frame(maxWidth: .infinity)
                .padding()
                .background(phone.isEmpty ? Color.red.opacity(0.5) : Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.6), radius: 5, x: 0, y: 4)
        }
        .disabled(phone.isEmpty)
    }
    
    var otpScreen: some View {
        Text("OTP Verification Screen")
            .font(.largeTitle)
            .foregroundColor(.white)
            .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    ForgotPasswordScreen()
}
