import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert = false
    
    func login() {
        // Implement your authentication logic here
        // For simplicity, we'll just compare with hardcoded credentials
        if email == "user" && password == "password" {
            // Handle successful login
            print("Login successful")
        } else {
            // Handle failed login
            showAlert = true
        }
    }
}
