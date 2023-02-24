//
//  PasswordTextField.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func toggleVisibility()
}

/// Separate class for passwordInput, conforming to UITextField due to requirement of delegate for usage in toggling secureTextEntry
class PasswordTextField: UITextField {

    weak var visibilityDelegate: PasswordTextFieldDelegate?

    /// Method for adding "eye" icon with available interaction
    /// - Parameter height: height of the parent class in order to set constraints for the icon
    func setupPasswordToggle(in height: CGFloat) {
        let imageView = UIImageView()
        let image = UIImage(named: "passwordEye")?.resizeImage(height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.75
        imageView.widthAnchor.constraint(equalToConstant: height * 2.5).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(togglePasswordVisibility)))

        rightView = imageView
        rightViewMode = .always
    }

    @objc func togglePasswordVisibility() {
        visibilityDelegate?.toggleVisibility()
    }
}
