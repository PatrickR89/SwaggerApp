//
//  UIButton+Extensions.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit

extension UIButton {
    /// Method to create standardized buttons with specific design
    func createStandardButton() {
        backgroundColor = UIConstants.buttonColor
        setTitleColor(UIConstants.backgroundColor, for: .normal)
        setTitleColor(.gray, for: .disabled)
        layer.cornerRadius = UIConstants.elementHeight / 2
        titleLabel?.font = UIFont(name: "Supreme-Bold", size: 17)!
    }
}
