import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    @State private var textFieldWidth : CGFloat = 0
    @State private var textFieldHeight : CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Forgot Password")
                .font(.title)
                .padding()
            
            VStack(alignment: .leading){
                TextField("Enter your email", text: $viewModel.email)
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
                    .accessibility(label: Text("Email")) // Set accessibility label
                if !viewModel.isEmailValid {
                    ErrorView(error: viewModel.emailError)
                }
            }
            Button(action: {
                viewModel.resetPassword()
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
