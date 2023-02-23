//
//  LoginView.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit
import Combine

class LoginView: UIView {

    let controller: LoginController
    private var cancellables = Set<AnyCancellable>()
    var spinner = UIActivityIndicatorView(style: .large)

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.createSMLabel()
        label.text = " E-MAIL "
        return label
    }()

    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.createSMLabel()
        label.text = " LOZINKA "
        return label
    }()

    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.createWarningLabel()
        return label
    }()

    lazy var usernameInput: UITextField = {
        let textField = UITextField()
        textField.setupBasicFrame()
        return textField
    }()

    lazy var passwordInput: PasswordTextField = {
        let textField = PasswordTextField()
        textField.setupBasicFrame()
        textField.setupPasswordToggle(in: UIConstants.elementHeight * 0.45)
        return textField
    }()

    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.createStandardButton()
        button.setTitle("LOG IN", for: .normal)
        return button
    }()

    init(_ controller: LoginController) {
        self.controller = controller
        super.init(frame: .zero)
        setupBindings()
    }

    deinit {
        cancellables = []
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func defineFrame(frame: CGRect) {
        self.frame = frame
        setupUI()
    }

    func setupUI() {
        backgroundColor = UIConstants.backgroundColor
        addPasswordInput()
        addUsernameInput()
        addSubmitButton()
        addUsernameLabel()
        addPasswordLabel()
        addWarningLabel()
    }

    private func setupBindings() {
        controller.$isPasswordVisible.sink { [weak self] isVisible in
            self?.passwordInput.isSecureTextEntry = isVisible
        }
        .store(in: &cancellables)

        controller.$isRequestLoading.sink { [weak self] isLoading in

                if isLoading {
                    DispatchQueue.main.async {
                        self?.addSpinner()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.removeSpinner()
                    }
                }

        }.store(in: &cancellables)

        controller.$warning.sink { [weak self] warning in
            guard let warning = warning else {
                self?.warningLabel.isHidden = true
                return
            }
            self?.warningLabel.text = warning
            self?.warningLabel.isHidden = false

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self?.controller.nullifyWarning()
            }
        }.store(in: &cancellables)
    }

    @objc func submitCredentials() {
        controller.requestLogin()
        passwordInput.text = ""
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if textField == usernameInput {
            controller.editUserCredentials(.email, text)
        } else if textField == passwordInput {
            controller.editUserCredentials(.password, text)
        }
    }
}
