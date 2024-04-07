import SwiftUI
struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var textFieldWidth: CGFloat = 0
    @State private var textFieldHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.title)
                .padding()
            
            VStack(alignment: .leading){
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(globalCornerRadius)
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                self.textFieldWidth = geometry.size.width
                                self.textFieldHeight = geometry.size.height
                            }
                        }
                    )
                    .padding(.bottom, viewModel.isEmailValid ? 20 : 0)
                    .accessibility(label: Text(viewModel.emailAccessibilityLabel))
                    .accessibility(hint: Text(viewModel.emailAccessibilityHint))
                
                if !viewModel.isEmailValid {
                    ErrorView(error: viewModel.emailError)
                }
                
                // Password SecureField with visibility toggle
                HStack {
                    if viewModel.isSecurePasswordEntry {
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .accessibility(label: Text(viewModel.passwordAccessibilityLabel))
                            .accessibility(hint: Text(viewModel.passwordAccessibilityHint))
                    } else {
                        TextField("Password", text: $viewModel.password)
                            .padding()
                    }
                    Button(action: {
                        viewModel.isSecurePasswordEntry.toggle()
                    }) {
                        Image(systemName: viewModel.isSecurePasswordEntry ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.primary)
                            .padding(.trailing)
                            .accessibility(label: Text(viewModel.passwordAccessibilityLabel))
                            .accessibility(hint: Text(viewModel.passwordAccessibilityHint))
                    }
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(globalCornerRadius)
                .padding(.bottom, viewModel.isPasswordValid ? 20 : 0)
                
                if !viewModel.isPasswordValid {
                    ErrorView(error: viewModel.passwordError)
                }
                
                // Confirm Password SecureField with visibility toggle
                HStack {
                    if viewModel.isSecureConfirmPasswordEntry {
                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                            .padding()
                            .accessibility(label: Text(viewModel.confirmPasswordAccessibilityLabel))
                            .accessibility(hint: Text(viewModel.confirmPasswordAccessibilityHint))
                    } else {
                        TextField("Confirm Password", text: $viewModel.confirmPassword)
                            .padding()
                    }
                    Button(action: {
                        viewModel.isSecureConfirmPasswordEntry.toggle()
                    }) {
                        Image(systemName: viewModel.isSecureConfirmPasswordEntry ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.primary)
                            .padding(.trailing)
                            .accessibility(label: Text(viewModel.confirmPasswordAccessibilityLabel))
                            .accessibility(hint: Text(viewModel.confirmPasswordAccessibilityHint))
                    }
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(globalCornerRadius)
                .padding(.bottom, viewModel.isConfirmPasswordValid ? 20 : 0)
                
                if !viewModel.isConfirmPasswordValid {
                    ErrorView(error: viewModel.confirmPasswordError)
                }
                
            }
            // Add sign-up button and its functionality here
            Button(action: {
                viewModel.signUp()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: textFieldWidth, height: textFieldHeight)
                    .background(Color("Primary"))
                    .cornerRadius(globalCornerRadius)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
