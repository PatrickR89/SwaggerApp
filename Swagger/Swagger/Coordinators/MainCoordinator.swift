//
//  MainCoordinator.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

/// Coordinator class responsible for navigating screens
/// - Parameter navController: `UINavigationController` instance which presents viewControllers
/// - Parameter apiService: ``APIService`` instance for HTTP requests
/// - Parameter loginController: ``LoginController`` instance containing login functionality
/// - Parameter detailsController: ``DetailsController`` instance containing details functionality
class MainCoordinator {

    private let navController: UINavigationController
    private let apiService: APIService
    private let loginController = LoginController()
    private var detailsController: DetailsController?

    /// Coordinator initializes with given parameters, also setting up delegacies
    /// - Parameters:
    ///   - navController: `UINavigationController` instance created in `SceneDelegate` and set as rootViewController
    ///   - service: ``APIService`` instance created in `SceneDelegate`, although not required to be passed from parent, it was designed in such matter in order to have availability for `MockAPIService` in test cases
    init(_ navController: UINavigationController, _ service: APIService) {
        self.navController = navController
        self.apiService = service
        loginController.actions = service
        service.delegate = loginController
        apiService.actions = self
    }

    /// Primary function of ``MainCoordinator`` checking availability of `AccessToken`in `UserDefaults`, and presenting proper ViewController based on token result
    func start() {

        if UserDefaults.standard.string(forKey: "AccessToken") == nil {
            let loginViewController = LoginViewController(loginController)
            navController.setViewControllers([loginViewController], animated: true)
        } else {
            apiService.fetchUserData()
        }
    }

    /// Helper method with task of creating and presenting instance of DetailsViewController
    /// - Parameter userData: ``UserResponse`` data recieved via ``APIService`` actions delegate from fetch method
    func initiateDetailViewController(for userData: UserResponse) {

        detailsController = DetailsController()
        detailsController?.actions = self
        guard let detailsController = detailsController else { return }
        detailsController.populateDataWith(userData)

        let detailsViewController = DetailsTableViewController(detailsController)
        navController.setViewControllers([detailsViewController], animated: true)
    }
}

extension MainCoordinator: APIServiceActions {
    func service(didRecieve userData: UserResponse) {
        initiateDetailViewController(for: userData)
    }
}

extension MainCoordinator: DetailsControllerActions {
    func controllerDidRequestLogout() {
        start()
    }
}
