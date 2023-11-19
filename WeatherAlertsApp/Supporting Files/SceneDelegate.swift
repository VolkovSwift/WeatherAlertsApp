//
//  SceneDelegate.swift
//  WeatherAlertsApp
//
//  Created by Uladislau Volkau on 11/15/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let networkingManager = NetworkingManager()
        let presenter = MainPresenter(networkingManager: networkingManager)
        let viewController = MainViewController(presenter: presenter)
        presenter.viewDelegate = viewController
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

