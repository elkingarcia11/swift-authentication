import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    
    @State private var textFieldWidth : CGFloat = 0
    @State private var textFieldHeight : CGFloat = 0
    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.title)
                .padding()
            
            TextField("Enter your email", text: $email)
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
            
            Button(action: {
                // Handle forgot password logic (e.g., send password reset email)
                print("Password reset email sent to: \(email)")
            }) {
                Text("Reset Password")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: textFieldWidth, height: textFieldHeight)
                    .background(Color("Primary"))
                    .cornerRadius(globalCornerRadius)
            }
            Spacer()
        }
        .padding()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
