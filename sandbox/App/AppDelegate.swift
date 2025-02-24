//
//  AppDelegate.swift
//  sandbox
//
//  Created by Botonota on 23.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let coordinator = AssetsCoordinator(navigationController: navigationController)
        coordinator.start()
        
        return true
    }
}

