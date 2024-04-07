import SwiftUI

class SignUpViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var email: String = ""
    @Published var emailError: String = ""
    @Published var password: String = ""
    @Published var passwordError: String = ""
    @Published var confirmPassword: String = ""
    @Published var confirmPasswordError: String = ""
    @Published var isSecurePasswordEntry = true
    @Published var isSecureConfirmPasswordEntry = true
    
    // MARK: - Validation Properties
    
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    @Published var isConfirmPasswordValid: Bool = true
    
    // MARK: - Accessibility Properties
    
    @Published var emailAccessibilityLabel: String = "Email"
    @Published var emailAccessibilityHint: String = "Enter your email"
    @Published var passwordAccessibilityLabel: String = "Password"
    @Published var passwordAccessibilityHint: String = "Enter your password"
    @Published var confirmPasswordAccessibilityLabel: String = "Confirm Password"
    @Published var confirmPasswordAccessibilityHint: String = "Confirm your password"
    
    // MARK: - Sign-Up Function
    
    func signUp() {
        validateEmail()
        validatePassword()
        validateConfirmPassword()
        
        if isEmailValid && isPasswordValid && isConfirmPasswordValid {
            // Perform sign-up logic
            print("Sign Up successful")
        } else {
            // Handle sign-up failure
            print("Sign Up failed")
        }
    }
    
    // MARK: - Validation Functions
    
    private func validateEmail() {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
        emailError = isEmailValid ? "" : "Email is invalid"
    }
    
    private func validatePassword() {
        guard password.count >= 8 else {
            passwordError = "Password must be at least 8 characters long"
            isPasswordValid = false
            return
        }
        
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let numberRegex = ".*[0-9]+.*"
        
        let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
        let lowercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex)
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        if uppercaseLetterTest.evaluate(with: password) && lowercaseLetterTest.evaluate(with: password) && numberTest.evaluate(with: password) {
            passwordError = ""
            isPasswordValid = true
        } else {
            if !uppercaseLetterTest.evaluate(with: password) {
                passwordError="Password must contain at least one uppercase letter"
            } else if !lowercaseLetterTest.evaluate(with: password) {
                passwordError="Password must contain at least one lowercase letter"
            } else {
                passwordError="Password must contain at least one number"
            }
            isPasswordValid = false
        }
    }
    
    private func validateConfirmPassword() {
        // Confirm password matches original password
        isConfirmPasswordValid = confirmPassword == password
        confirmPasswordError = isConfirmPasswordValid ? "" : "Passwords must match"
    }
}
