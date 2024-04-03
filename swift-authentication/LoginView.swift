//
//  View.swift
//  swift-authentication
//
//  Created by Elkin Garcia on 4/3/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
    @State private var textFieldWidth: CGFloat = 0
    @State private var textFieldHeight: CGFloat = 0
    @State private var isSecureTextEntry = true

    
    var body: some View {
        ZStack{
            VStack {
                // Logo Image
                Image("Logo") // Replace "YourLogoImage" with the name of your logo image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5.0)
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                self.textFieldWidth = geometry.size.width
                                self.textFieldHeight = geometry.size.height
                            }
                        }
                    )
                    .padding(.bottom, 20)
                
                // Password SecureField with visibility toggle
                HStack {
                    if isSecureTextEntry {
                        SecureField("Password", text: $viewModel.password)
                            .padding()
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
                    }
                }
                .background(Color(UIColor.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                
                Button(action: {
                    // Handle login action
                    self.viewModel.login()
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: textFieldWidth, height: textFieldHeight)
                        .background(Color("Primary"))
                        .cornerRadius(5.0)
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text("Invalid credentials"), dismissButton: .default(Text("OK")))
                }
                
                Button(action: {
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: textFieldWidth, height: textFieldHeight)
                        .cornerRadius(5.0)
                }
                
                Spacer()
                
                HStack(alignment: .center){
                    Text("Don't have an account?").foregroundColor(Color("SecondaryOne"))
                    
                    Button(action: {
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .cornerRadius(5.0)
                    }
                }
                .frame(width: textFieldWidth, height: textFieldHeight)
                
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
