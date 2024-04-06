import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    @State private var textFieldWidth: CGFloat = 0
    @State private var textFieldHeight: CGFloat = 0
    @State private var isSecureTextEntry = true
    
    
    // State to control presentation of Forgot Password sheet
    @State private var isForgotPasswordSheetPresented = false
    
    var body: some View {
        ZStack{
            VStack {
                // Logo Image
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .accessibility(hidden: true) // Hide logo from accessibility
                
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
                    .padding(.bottom, 20)
                    .accessibility(label: Text("Email")) // Set accessibility label
                
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
                .padding(.bottom, 20)
                .accessibility(label: Text("Password")) // Set accessibility label
                
                
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
                        // Handle sign up action
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .cornerRadius(globalCornerRadius)
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
