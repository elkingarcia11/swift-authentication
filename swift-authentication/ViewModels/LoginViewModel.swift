import Foundation

class LoginViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var showAlert = false
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    @Published var isForgotPasswordSheetPresented = false
    @Published var isSignUpSheetPresented = false
    @Published var isSecureTextEntry = true
    
    @Published var email: String = ""
    @Published var emailError: String = ""
    @Published var password: String = ""
    @Published var passwordError: String = ""
    
    // MARK: - Accessibility Labels and Hints
    
    let emailAccessibilityLabel = "Email"
    let emailAccessibilityHint = "Enter your email"
    let passwordAccessibilityLabel = "Password"
    let passwordAccessibilityHint = "Enter your password"
    
    // MARK: - Login Function
    
    func login() {
        validateEmail()
        validatePassword()
        if isEmailValid && isPasswordValid {
            print("Email and password are valid")
            showAlert = false
        } else {
            showAlert = true
        }
    }
    
    // MARK: - Validation Functions
    
    private func validateEmail() {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if emailPredicate.evaluate(with: email) {
            emailError = ""
            isEmailValid = true
        } else {
            emailError = "Email is invalid"
            isEmailValid = false
        }
    }
    
    private func validatePassword() {
        guard password.count >= 8 else {
            passwordError = "Password must be at least 8 characters long"
            isPasswordValid = false
            return
        }
        
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
        
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let lowercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex)
        
        let numberRegex = ".*[0-9]+.*"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        if uppercaseLetterTest.evaluate(with: password) && lowercaseLetterTest.evaluate(with: password) && numberTest.evaluate(with: password) {
            passwordError = ""
            isPasswordValid = true
        } else {
            if !uppercaseLetterTest.evaluate(with: password) {
                passwordError = "Password must contain at least one uppercase letter"
            } else if !lowercaseLetterTest.evaluate(with: password) {
                passwordError = "Password must contain at least one lowercase letter"
            } else {
                passwordError = "Password must contain at least one number"
            }
            isPasswordValid = false
        }
    }
    
    // MARK: - Presentation State Toggling Functions
    
    func toggleForgotPasswordSheet() {
        isForgotPasswordSheetPresented.toggle()
    }
    
    func toggleSignUpSheet() {
        isSignUpSheetPresented.toggle()
    }
}
