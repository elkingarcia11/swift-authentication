# Authentication SwiftUI Project

This project is a SwiftUI-based application aimed at providing authentication functionalities such as login, sign up, and password reset.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Overview

The project consists of several SwiftUI views and view models to handle authentication tasks. It includes:

- **LoginView**: Allows users to log in with their email and password. Provides validation for email and password fields.
- **SignUpView**: Enables users to sign up by providing their email, password, and confirming the password. Validates email format and password strength.
- **ForgotPasswordView**: Allows users to reset their password by providing their email address. Validates email format.
- **LoginViewModel**: Manages the logic and data handling for the login functionality.
- **SignUpViewModel**: Manages the logic and data handling for the sign-up functionality.
- **ForgotPasswordViewModel**: Manages the logic and data handling for the forgot password functionality.

## Features

- User authentication including login, sign up, and password reset.
- Field validations for email and password inputs.
- Password strength validation during sign up.
- Accessibility features integrated for improved usability.
- Responsive UI design using SwiftUI.

## Usage

To use this project, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the application on your simulator or device.

## Folder Structure

The project follows a structured organization as follows:

```
AuthenticationSwiftUI
├── Models
│   ├── // Any additional models used in the project
├── Views
│   ├── LoginView.swift
│   ├── SignUpView.swift
│   ├── ForgotPasswordView.swift
│   ├── // Any additional views
├── ViewModels
│   ├── LoginViewModel.swift
│   ├── SignUpViewModel.swift
│   ├── ForgotPasswordViewModel.swift
│   ├── // Any additional view models
├──  // Any additional resources
└── README.md
```

## Dependencies

The project does not have any external dependencies.

## Contributing

Contributions to the project are welcome. To contribute, please fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

---

Feel free to customize this README according to your project's specifics and requirements. Let me know if you need further assistance!
