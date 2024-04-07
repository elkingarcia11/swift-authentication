import SwiftUI

class ForgotPasswordViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var email: String = ""
    @Published var isEmailValid: Bool = true
    @Published var emailError: String = ""
    
    // MARK: - Reset Password Function
    
    func resetPassword() {
        validateEmail()
        if email.isEmpty {
            emailError = "Email is required."
        } else if !isEmailValid {
            emailError = "Please enter a valid email address."
        } else {
            // Handle forgot password logic (e.g., send password reset email)
            emailError = ""
        }
    }
    
    // MARK: - Email Validation
    
    private func validateEmail() {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
    }
}
