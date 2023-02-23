//
//  MainCoordinator.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class MainCoordinator {

    private let navController: UINavigationController
    let apiService: APIService
    let loginController = LoginController()

    init(_ navController: UINavigationController, _ service: APIService) {
        self.navController = navController
        self.apiService = service
        loginController.actions = service
    }

    func start() {
        let loginViewController = LoginViewController(loginController)
        navController.pushViewController(loginViewController, animated: true)
    }
}
