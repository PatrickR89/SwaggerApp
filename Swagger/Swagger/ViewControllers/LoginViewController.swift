//
//  LoginViewController.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

/// ViewController responsible for presenting login screen
/// - Parameter loginView: ``LoginView`` containing all element presented on the screen
/// - Parameter loginController: ``LoginController`` containing all functionality and logic for login screen
class LoginViewController: UIViewController {

    private let loginView: LoginView
    private let loginController: LoginController

    /// ViewController initializes with given parameters in order to provide controller to view
    /// - Parameter controller: ``LoginController`` instance created in parent class in order to have proper delegate methods to `service`
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
