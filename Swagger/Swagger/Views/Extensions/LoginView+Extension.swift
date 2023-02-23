//
//  LoginView+Extension.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit

extension LoginView {

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
