//
//  UItextField+Extensions.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

extension UITextField {
    func setupBasicFrame() {
        textColor = UIConstants.textColor
        layer.borderWidth = 1.5
        layer.borderColor = UIConstants.textColor.cgColor
        layer.cornerRadius = 10
        font = UIFont(name: "Supreme-Regular", size: 19)

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
    }

    func setupPasswordToggle(in height: CGFloat) {
        let imageView = UIImageView()
        let image = UIImage(named: "passwordEye")?.resizeImage(height)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.75
        imageView.widthAnchor.constraint(equalToConstant: height * 2.5).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = image

        rightView = imageView
        rightViewMode = .always
    }
}
