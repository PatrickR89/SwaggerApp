//
//  LoginViewController.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView: LoginView
    private let loginController: LoginController

    init(_ controller: LoginController) {
        self.loginView = LoginView(controller)
        self.loginController = controller
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        loginView.defineFrame(frame: view.frame)
        view = loginView
    }
}
