//
//  LoginViewController.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }

    func setupUI() {
        loginView.frame = view.frame
        loginView.setupUI()
        view = loginView
    }
}

