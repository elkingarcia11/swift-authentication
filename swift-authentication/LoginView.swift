import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    @State private var textFieldWidth: CGFloat = 0
    @State private var textFieldHeight: CGFloat = 0
    
    // State to control visiblity of password
    @State private var isSecureTextEntry = true
    // State to control presentation of Forgot Password sheet
    @State private var isForgotPasswordSheetPresented = false
    // State to control presentation of Sign Up sheet
    @State private var isSignUpSheetPresented = false
    
    var body: some View {
        ZStack{
            VStack {
                // Logo Image
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .accessibility(hidden: true) // Hide logo from accessibility
                
                VStack(alignment: .leading){
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
                        .accessibility(label: Text("Email")) // Set accessibility label
                    
                    if !viewModel.emailError.isEmpty {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .padding([.top, .trailing], 5)
                            Text(viewModel.emailError)
                                .foregroundColor(.red)
                        }
                        .padding(.bottom, 20)
                    }
                    
                    
                    // Password SecureField with visibility toggle
                    HStack {
                        if isSecureTextEntry {
                            SecureField("Password", text: $viewModel.password)
                                .padding()
                                .accessibility(label: Text("Password")) // Set accessibility label
                                .accessibility(hint: Text("Enter your password")) // Set accessibility hint
                        } else {
                            TextField("Password", text: $viewModel.password)
                                .padding()
                        }
                        Button(action: {
                            isSecureTextEntry.toggle()
                        }) {
                            Image(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.primary)
                                .padding(.trailing)
                                .accessibility(label: Text("Password")) // Set accessibility label
                                .accessibility(hint: Text("Enter your password")) // Set accessibility hint
                        }
                    }
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(globalCornerRadius)
                    .padding(.bottom, viewModel.passwordError.isEmpty ? 20 : 0)
                    .accessibility(label: Text("Password")) // Set accessibility label
                    
                    if !viewModel.passwordError.isEmpty {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .padding([.top, .trailing], 5)
                            Text(viewModel.passwordError)
                                .foregroundColor(.red)
                        }
                        .padding(.bottom, 20)
                    }
                    
                }
                // Login Button
                Button(action: {
                    // Handle login action
                    self.viewModel.login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: textFieldWidth, height: textFieldHeight)
                        .background(Color("Primary"))
                        .cornerRadius(globalCornerRadius)
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text("Invalid credentials"), dismissButton: .default(Text("OK")))
                }
                
                // Forgot Password Button
                Button(action: {
                    // Show Forgot Password sheet
                    self.isForgotPasswordSheetPresented.toggle()
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.black)
                        .padding()
                        .cornerRadius(globalCornerRadius)
                }
                .sheet(isPresented: $isForgotPasswordSheetPresented) {
                    // Present Forgot Password sheet
                    ForgotPasswordView()
                }
                
                Spacer()
                
                // Sign Up Text
                HStack(alignment: .center){
                    Text("Don't have an account?").foregroundColor(Color("SecondaryOne"))
                    
                    Button(action: {
                        // Show sign-up sheet
                        self.isSignUpSheetPresented.toggle()
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .cornerRadius(globalCornerRadius)
                    }
                    .sheet(isPresented: $isSignUpSheetPresented) {
                        // Present SignUpView when isSignUpSheetPresented is true
                        SignUpView()
                    }
                }
                
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
