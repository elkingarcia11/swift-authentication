import Foundation

class LoginViewModel: ObservableObject {
    @Published var showAlert = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    
    // State to control presentation of Forgot Password sheet
    @Published var isForgotPasswordSheetPresented = false
    
    // State to control presentation of Sign Up sheet
    @Published var isSignUpSheetPresented = false
    
    
    @Published var isSecureTextEntry = true
    
    // Accessibility labels and hints
    let emailAccessibilityLabel = "Email"
    let emailAccessibilityHint = "Enter your email"
    let passwordAccessibilityLabel = "Password"
    let passwordAccessibilityHint = "Enter your password"
    
    func login() {
        if isValidEmail(email) && isValidPassword(password){
            print("Email and password successful")
        } else{
            // Handle failed login
            showAlert = true
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Perform email validation logic
        // Return true if valid, false otherwise
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailPredicate.evaluate(with: email) {
            emailError = ""
            return true
        }
        emailError = "Email is invalid"
        return false
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // Perform password validation logic
        // Return true if valid, false otherwise
        
        // Minimum length requirement (change as needed)
        guard password.count >= 8 else {
            passwordError = "Password needs to be at least 8 characters"
            return false
        }
        
        // Additional password complexity rules (add more as needed)
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
        
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let lowercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex)
        
        let numberRegex = ".*[0-9]+.*"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        if uppercaseLetterTest.evaluate(with: password) {
            if lowercaseLetterTest.evaluate(with: password) {
                if numberTest.evaluate(with: password) {
                    passwordError = ""
                    return true
                } else {
                    passwordError = "Password needs at least one number"
                    return false
                }
            } else{
                passwordError = "Password needs at least one lowercase letter"
                return false
            }
        } else {
            passwordError = "Password needs at least one uppercase letter"
            return false
        }
    }
    
    // Functions to toggle the presentation states
    func toggleForgotPasswordSheet() {
        isForgotPasswordSheetPresented.toggle()
    }
    
    func toggleSignUpSheet() {
        isSignUpSheetPresented.toggle()
    }
}
