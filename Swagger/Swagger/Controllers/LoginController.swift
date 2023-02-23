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
}

extension LoginController: PasswordTextFieldDelegate {
    func didToggleVisibility() {
        isPasswordVisible = !isPasswordVisible
    }
}
