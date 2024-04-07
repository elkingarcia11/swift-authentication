import SwiftUI

struct SignUpView: View {
    // Add any necessary state variables for sign-up process
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isSecurePasswordEntry = true
    @State private var isSecureConfirmPasswordEntry = true
    
    @State private var textFieldWidth: CGFloat = 0
    @State private var textFieldHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.title)
                .padding()
            
            TextField("Email", text: $email)
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
                .accessibility(label: Text("Email"))
            
            // Password SecureField with visibility toggle
            HStack {
                if isSecurePasswordEntry {
                    SecureField("Password", text: $password)
                        .padding()
                        .accessibility(label: Text("Password")) // Set accessibility label
                        .accessibility(hint: Text("Enter your password")) // Set accessibility hint
                } else {
                    TextField("Password", text: $password)
                        .padding()
                }
                Button(action: {
                    isSecurePasswordEntry.toggle()
                }) {
                    Image(systemName: isSecurePasswordEntry ? "eye.slash.fill" : "eye.fill")
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
            
            // Password SecureField with visibility toggle
            HStack {
                if isSecureConfirmPasswordEntry {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .accessibility(label: Text("Confirm Password")) // Set accessibility label
                        .accessibility(hint: Text("Confirm your password")) // Set accessibility hint
                } else {
                    TextField("Confirm Password", text: $confirmPassword)
                        .padding()
                }
                Button(action: {
                    isSecureConfirmPasswordEntry.toggle()
                }) {
                    Image(systemName: isSecureConfirmPasswordEntry ? "eye.slash.fill" : "eye.fill")
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
            
            // Add sign-up button and its functionality here
            Button(action: {
                // Handle sign-up action
                print("Sign Up tapped")
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
