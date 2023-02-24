//
//  SceneDelegate.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return }

            let navController = NavigationController()
            let service = APIService()
            navController.view.backgroundColor = UIConstants.backgroundColor
            mainCoordinator = MainCoordinator(navController, service)
            mainCoordinator?.start()

            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
}

class NavigationController: UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}
