//
//  LoginController.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import Foundation
import Combine

enum UserCredentials {
    case email
    case password
}

protocol LoginControllerActions: AnyObject {
    func loginController(didRequestLoginFor user: String, with password: String)
}

class LoginController {
    private(set) var email = ""
    private(set) var password = ""
    @Published private(set) var isPasswordVisible = true
    @Published private(set) var isRequestLoading = false
    @Published private(set) var warning: String? = "Some warning"

    weak var actions: LoginControllerActions?

    func editUserCredentials(_ credential: UserCredentials, _ value: String) {
        switch credential {
        case .email:
            email = value
        case .password:
            password = value
        }
    }

    func requestLogin() {
        actions?.loginController(didRequestLoginFor: email, with: password)
    }

    func test() {
        print(email, password)
    }

    func nullifyWarning() {
        warning = nil
    }
}

extension LoginController: PasswordTextFieldDelegate {
    func toggleVisibility() {
        isPasswordVisible = !isPasswordVisible
    }
}

extension LoginController: APIServiceDelegate {
    func service(isWaiting: Bool) {
        isRequestLoading = isWaiting
    }
}
