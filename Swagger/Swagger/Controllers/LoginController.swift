//
//  LoginController.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation
import Combine

/// Enum used in `editUserCredentials` method in order to avoid using multiple functions with same purpose
enum UserCredentials {
    case email
    case password
}

protocol LoginControllerActions: AnyObject {
    func loginController(didRequestLoginFor user: String, with password: String)
}

/// Class which contains functionality for login in order to separate functionality from UI.
///  - Parameter email: recieves user input for emailInput text value from ``LoginView``
///  - Parameter password: recieves user input for passwordInput text value from ``LoginView``
///  - Parameter isPasswordVisible: Bool value, toggled by "eye" icon in passwordInput text field in ``LoginView``, published for use on passwordInput to toggle secureTextEntryt
///  - Parameter isRequestLoading: Bool value, toggled by ``APIService`` methods to present application state while waiting on response upon sent request
///  - Parameter warning: Optional string, changed by ``APIService`` methods, in case notNil value triggers warning label show in ``LoginView`` with recieved message
class LoginController {
    private(set) var email = ""
    private(set) var password = ""
    @Published private(set) var isPasswordVisible = true
    @Published private(set) var isRequestLoading = false
    @Published private(set) var warning: String?

    weak var actions: LoginControllerActions?

    /// Method called by LoginView via `UITextFieldDelegate` to change email or password values upon input changes
    /// - Parameters:
    ///   - credential: ``UserCredentials`` value used to select proper variable depending on used input field
    ///   - value: String value passed from input's text value
    func editUserCredentials(_ credential: UserCredentials, _ value: String) {
        switch credential {
        case .email:
            email = value
        case .password:
            password = value
        }
    }

    /// Method tied to login button with destination in ``APIService``
    func requestLogin() {
        actions?.loginController(didRequestLoginFor: email, with: password)
    }

    /// Method to remove warning label in ``LoginView``
    func nullifyWarning() {
        warning = nil
    }
}

extension LoginController: PasswordTextFieldDelegate {
    /// Method to toggle passwordInput secureTextEntry in ``LoginView``
    func toggleVisibility() {
        isPasswordVisible = !isPasswordVisible
    }
}

extension LoginController: APIServiceDelegate {
    /// ``APIService`` delegate method for providing error message
    /// - Parameter errorMessage: String value of error message
    func service(didRecieve errorMessage: String) {
        DispatchQueue.main.async {
            self.warning = errorMessage
        }
    }

    /// ``APIService`` delegate method for providing "waiting for response" state
    /// - Parameter isWaiting: Bool value of curent HTTP waiting for response state
    func service(isWaiting: Bool) {
        isRequestLoading = isWaiting
    }
}
