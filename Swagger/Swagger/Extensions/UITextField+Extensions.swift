//
//  UITextField+Extensions.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

extension UITextField {
    /// Method to set up visual output for input fields, separated from ``LoginView`` for cleaner code
    func setupBasicFrame() {
        textColor = UIConstants.textColor
        layer.borderWidth = 1.5
        layer.borderColor = UIConstants.textColor.cgColor
        layer.cornerRadius = 10
        font = UIFont(name: "Supreme-Regular", size: 19)
        autocorrectionType = .no
        autocapitalizationType = .none
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
    }
}
