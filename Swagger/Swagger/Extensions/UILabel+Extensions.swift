//
//  UILabel+Extensions.swift
//  Swagger
//
//  Created by Patrick on 23.02.2023..
//

import UIKit


extension UILabel {
    func createSMLabel() {
        textColor = UIConstants.textColor
        backgroundColor = UIConstants.backgroundColor
        font = UIFont(name: "Supreme-Extrabold", size: 12)
    }

    func createWarningLabel() {
        text = ""
        textAlignment = .center
        backgroundColor = UIConstants.warningColor
        textColor = .red
        layer.cornerRadius = UIConstants.elementHeight / 2
        font = UIFont(name: "Supreme-Bold", size: 17)!
        layer.masksToBounds = true
    }
}
