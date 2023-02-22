//
//  MainCoordinator.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class MainCoordinator {

    private let navController: UINavigationController

    init(_ navController: UINavigationController) {
        self.navController = navController
    }

    func start() {
        let loginViewController = LoginViewController()
        navController.pushViewController(loginViewController, animated: true)
    }
}
