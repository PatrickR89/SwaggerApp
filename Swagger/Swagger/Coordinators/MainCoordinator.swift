//
//  MainCoordinator.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

class MainCoordinator {

    private let navController: UINavigationController
    private let apiService: APIService
    private let loginController = LoginController()
    private var detailsController: DetailsController?

    init(_ navController: UINavigationController, _ service: APIService) {
        self.navController = navController
        self.apiService = service
        loginController.actions = service
        service.delegate = loginController
        apiService.actions = self
    }

    func start() {

        if UserDefaults.standard.string(forKey: "AccessToken") == nil {
            let loginViewController = LoginViewController(loginController)
            navController.setViewControllers([loginViewController], animated: true)
        } else {
            apiService.fetchUserData()
        }
    }

    func initiateDetailViewController(for userData: UserResponseFiltered) {

        detailsController = DetailsController()
        detailsController?.actions = self
        guard let detailsController = detailsController else { return }
        detailsController.populateDataWith(userData)

        let detailsViewController = DetailsTableViewController(detailsController)
        navController.setViewControllers([detailsViewController], animated: true)
    }
}

extension MainCoordinator: APIServiceActions {
    func service(didRecieve userData: UserResponseFiltered) {
        initiateDetailViewController(for: userData)
    }
}

extension MainCoordinator: DetailsControllerActions {
    func controllerDidRequestLogout() {
        start()
    }
}
