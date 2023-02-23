//
//  LoginView.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit
import Combine

class LoginView: UIView {

    private let controller: LoginController
    private var cancellables = Set<AnyCancellable>()
    var spinner = UIActivityIndicatorView(style: .large)

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIConstants.textColor
        label.backgroundColor = UIConstants.backgroundColor
        label.font = UIFont(name: "Supreme-Extrabold", size: 12)

        label.text = " E-MAIL "
        return label
    }()

    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIConstants.textColor
        label.backgroundColor = UIConstants.backgroundColor
        label.font = UIFont(name: "Supreme-Extrabold", size: 12)
        label.text = " LOZINKA "
        return label
    }()

    lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "warning"
        label.textAlignment = .center
        label.backgroundColor = UIConstants.warningColor
        label.textColor = .red
        label.layer.cornerRadius = UIConstants.elementHeight / 2
        label.font = UIFont(name: "Supreme-Bold", size: 17)!
        label.layer.masksToBounds = true

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
        button.backgroundColor = UIConstants.buttonColor
        button.setTitleColor(UIConstants.backgroundColor, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = UIConstants.elementHeight / 2
        button.titleLabel?.font = UIFont(name: "Supreme-Bold", size: 17)!
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

    @objc private func submitCredentials() {
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

private extension LoginView {

    func addPasswordInput() {
        addSubview(passwordInput)
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.delegate = self
        passwordInput.visibilityDelegate = controller

        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordInput.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(bounds.height / 4)),
            passwordInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            passwordInput.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight)
        ])
    }

    func addUsernameInput() {
        addSubview(usernameInput)
        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        usernameInput.delegate = self

        NSLayoutConstraint.activate([
            usernameInput.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameInput.bottomAnchor.constraint(equalTo: passwordInput.topAnchor, constant: -UIConstants.margin),
            usernameInput.widthAnchor.constraint(equalTo: passwordInput.widthAnchor),
            usernameInput.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight)
        ])
    }

    func addSubmitButton() {
        addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitCredentials), for: .touchUpInside)

        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: UIConstants.margin),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: passwordInput.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight)
        ])
    }

    func addUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameLabel.heightAnchor.constraint(equalTo: usernameInput.heightAnchor, multiplier: 0.2),
            usernameLabel.topAnchor.constraint(
                equalTo: usernameInput.topAnchor,
                constant: -UIConstants.labelVerticalPosition),
            usernameLabel.leadingAnchor.constraint(
                equalTo: usernameInput.leadingAnchor,
                constant: UIConstants.margin / 2.5)
        ])
    }

    func addPasswordLabel() {
        addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            passwordLabel.heightAnchor.constraint(equalTo: passwordInput.heightAnchor, multiplier: 0.2),
            passwordLabel.topAnchor.constraint(
                equalTo: passwordInput.topAnchor,
                constant: -UIConstants.labelVerticalPosition),
            passwordLabel.leadingAnchor.constraint(
                equalTo: passwordInput.leadingAnchor,
                constant: UIConstants.margin / 2.5)
        ])
    }

    func addSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()
        submitButton.isEnabled = false

        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -5),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func removeSpinner() {
        spinner.stopAnimating()
        submitButton.isEnabled = true
    }

    func addWarningLabel() {
        addSubview(warningLabel)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -25),
            warningLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            warningLabel.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight),
            warningLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
