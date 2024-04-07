import SwiftUI

/// A view representing the login screen.
struct LoginView: View {
    /// View model responsible for login logic and data handling.
    @ObservedObject var viewModel = LoginViewModel()
    
    /// Width of the text field.
    @State private var textFieldWidth: CGFloat = 0
    /// Height of the text field.
    @State private var textFieldHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                // Logo Image
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .accessibility(hidden: true) // Hide logo from accessibility
                
                VStack(alignment: .leading) {
                    // Email TextField
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
                        .padding(.bottom, viewModel.emailError.isEmpty ? 20 : 0)
                        .accessibility(label: Text(viewModel.emailAccessibilityLabel))
                        .accessibility(hint: Text(viewModel.emailAccessibilityHint))
                    
                    if !viewModel.emailError.isEmpty {
                        ErrorView(error: viewModel.emailError)
                    }
                    
                    // Password SecureField with visibility toggle
                    PasswordField(isSecureTextEntry: $viewModel.isSecureTextEntry, password: $viewModel.password)
                        .padding(.bottom, viewModel.passwordError.isEmpty ? 20 : 0)
                        .accessibility(label: Text("Password")) // Set accessibility label
                    
                    if !viewModel.passwordError.isEmpty {
                        ErrorView(error: viewModel.passwordError)
                    }
                    
                    // Login Button
                    LoginButton(textFieldWidth: $textFieldWidth, textFieldHeight: $textFieldHeight, viewModel: viewModel)
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(title: Text("Error"), message: Text("Invalid credentials"), dismissButton: .default(Text("OK")))
                        }
           
                }
                .padding()
                
                // Forgot Password Button
                ForgotPasswordButton(viewModel: viewModel)
                
                Spacer()
                
                // Sign Up Text
                SignUpText(viewModel: viewModel)
            }
        }
    }
}

/// A view to represent errors.
struct ErrorView: View {
    let error: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .padding([.top, .trailing], 5)
            Text(error)
                .foregroundColor(.red)
        }
        .padding(.bottom, 20)
    }
}

/// A view representing a password field.
struct PasswordField: View {
    @Binding var isSecureTextEntry: Bool
    @Binding var password: String
    
    var body: some View {
        HStack {
            if isSecureTextEntry {
                SecureField("Password", text: $password)
                    .padding()
            } else {
                TextField("Password", text: $password)
                    .padding()
            }
            Button(action: {
                isSecureTextEntry.toggle()
            }) {
                Image(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.primary)
                    .padding(.trailing)
            }
        }
        .background(Color(UIColor.systemGray6))
        .cornerRadius(globalCornerRadius)
    }
}

/// A button for login action.
struct LoginButton: View {
    @Binding var textFieldWidth: CGFloat
    @Binding var textFieldHeight: CGFloat
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            viewModel.login()
        }) {
            Text("Login")
                .foregroundColor(.white)
                .padding()
                .frame(width: textFieldWidth, height: textFieldHeight)
                .background(Color("Primary"))
                .cornerRadius(globalCornerRadius)
        }
    }
}

/// A button to handle forgot password.
struct ForgotPasswordButton: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleForgotPasswordSheet()
        }) {
            Text("Forgot Password?")
                .foregroundColor(.black)
                .padding()
                .cornerRadius(globalCornerRadius)
        }
        .sheet(isPresented: $viewModel.isForgotPasswordSheetPresented) {
            ForgotPasswordView()
        }
    }
}

/// A view for sign-up text and button.
struct SignUpText: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        HStack(alignment: .center){
            Text("Don't have an account?").foregroundColor(Color("SecondaryOne"))
            
            Button(action: {
                viewModel.toggleSignUpSheet()
            }) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .cornerRadius(globalCornerRadius)
            }
            .sheet(isPresented: $viewModel.isSignUpSheetPresented) {
                SignUpView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
