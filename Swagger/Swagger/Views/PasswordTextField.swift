//
//  PasswordTextField.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func didToggleVisibility()
}

class PasswordTextField: UITextField {

    weak var visibilityDelegate: PasswordTextFieldDelegate?

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
        visibilityDelegate?.didToggleVisibility()
    }
}
