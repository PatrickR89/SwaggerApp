//
//  LoginView.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class LoginView: UIView {

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

    lazy var usernameInput: UITextField = {
        let textField = UITextField()
        textField.setupBasicFrame()
        return textField
    }()

    lazy var passwordInput: UITextField = {
        let textField = UITextField()
        textField.setupBasicFrame()
        textField.setupPasswordToggle(in: UIConstants.elementHeight * 0.45)
        return textField
    }()

    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIConstants.buttonColor
        button.setTitleColor(UIConstants.backgroundColor, for: .normal)
        button.layer.cornerRadius = UIConstants.elementHeight / 2
        button.titleLabel?.font = UIFont(name: "Supreme-Bold", size: 17)!
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
        addSubview(usernameLabel)
        addSubview(passwordLabel)

        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false



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
            submitButton.heightAnchor.constraint(equalToConstant: UIConstants.elementHeight),
            usernameLabel.heightAnchor.constraint(equalTo: usernameInput.heightAnchor, multiplier: 0.2),
            usernameLabel.topAnchor.constraint(equalTo: usernameInput.topAnchor, constant: -5),
            usernameLabel.leadingAnchor.constraint(equalTo: usernameInput.leadingAnchor, constant: UIConstants.margin / 2.5),
            passwordLabel.heightAnchor.constraint(equalTo: passwordInput.heightAnchor, multiplier: 0.2),
            passwordLabel.topAnchor.constraint(equalTo: passwordInput.topAnchor, constant: -5),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordInput.leadingAnchor, constant: UIConstants.margin / 2.5)
        ])
    }
}
