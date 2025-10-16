
import SwiftUI

struct SignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var phone: String = ""
    
    @State private var showAlert = false
    @State private var isSuccess = false
    @State private var alertMessage = ""
    
    private var isAllFieldsFilled: Bool {
        fullName.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack(spacing: 20) {
                logoSection
                titleSection
                inputFields
                signUpButton
                bottomLinks
            }
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(isSuccess ? "Success" : "Warning"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

private extension SignUpScreen {
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
            Text("Create Account")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
            
            Text("Join The Food Bros Family")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
        }
    }
    
    var inputFields: some View {
        VStack(spacing: 15) {
            CustomTextField(icon: "person.fill", placeholder: "Full Name", text: $fullName)
            CustomTextField(icon: "person", placeholder: "Username", text: $username)
            CustomTextField(icon: "envelope.fill", placeholder: "Email", text: $email, keyboardType: .emailAddress)
            CustomSecureField(icon: "lock.fill", placeholder: "Password", text: $password)
            CustomTextField(icon: "phone.fill", placeholder: "Phone Number", text: $phone, keyboardType: .phonePad)
        }
    }
    
    var signUpButton: some View {
        Button(action: {
            signUpUser()
        }) {
            Text("SIGN UP")
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
            Text("Already have an account?")
                .foregroundColor(.white.opacity(0.8))
                .font(.footnote)
            
            Button("Login") {
                dismiss()
            }
            .foregroundColor(.red)
            .font(.footnote)
        }
        .padding(.top, 10)
    }
}

private extension SignUpScreen {
    func signUpUser() {
        let newUser = CreateUser(
            fullName: fullName,
            username: username,
            email: email,
            passwordHash: password,
            phoneNumber: phone
        )
        
        UserPresenter().isValidUser(user: newUser) { success in
            DispatchQueue.main.async {
                if success {
                    UserPresenter().createUser(user: newUser)
                    isSuccess = true
                    alertMessage = "User created successfully!"
                } else {
                    isSuccess = false
                    alertMessage = "User already exists. Please provide a unique user."
                    clearFields()
                }
                showAlert = true
            }
        }
    }
    
    func clearFields() {
        fullName = ""
        username = ""
        email = ""
        password = ""
        phone = ""
    }
}



#Preview {
    SignUpScreen()
}


