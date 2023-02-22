//
//  LoginView.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class LoginView: UIView {

    lazy var usernameInput: UITextField = {
        let textField = UITextField()
        textField.textColor = UIConstants.textColor
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIConstants.textColor.cgColor
        textField.layer.cornerRadius = 10
        return textField
    }()

    lazy var passwordInput: UITextField = {
        let textField = UITextField()
        textField.textColor = UIConstants.textColor
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIConstants.textColor.cgColor
        textField.layer.cornerRadius = 10

        return textField
    }()

    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIConstants.buttonColor
        button.setTitleColor(UIConstants.backgroundColor, for: .normal)
        button.layer.cornerRadius = UIConstants.elementHeight / 2
        button.setTitle("LOG IN", for: .normal)
        return button
    }()

    init() {
        super.init(frame: .zero)
//        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = UIConstants.backgroundColor
        addSubview(usernameInput)
        addSubview(passwordInput)
        addSubview(submitButton)

        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordInput.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -(bounds.height / 4)),
            usernameInput.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameInput.bottomAnchor.constraint(equalTo: passwordInput.topAnchor, constant: -UIConstants.margin),
            passwordInput.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            usernameInput.widthAnchor.constraint(equalTo: passwordInput.widthAnchor),
            passwordInput.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight),
            usernameInput.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight),
            submitButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: UIConstants.margin),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: passwordInput.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight)
        ])
    }
}
