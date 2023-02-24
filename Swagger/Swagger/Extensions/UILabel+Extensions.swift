//
//  UILabel+Extensions.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit


extension UILabel {
    /// Method to create small `UILabels` which are later appended to inputs
    func createSMLabel() {
        textColor = UIConstants.textColor
        backgroundColor = UIConstants.backgroundColor
        font = UIFont(name: "Supreme-Extrabold", size: 12)
    }

    /// Method to create `warningLabel`
    func createWarningLabel() {
        text = ""
        textAlignment = .center
        backgroundColor = UIConstants.warningColor
        textColor = .red
        layer.cornerRadius = 10
        font = UIFont(name: "Supreme-Bold", size: 17)!
        layer.masksToBounds = true
    }
}
