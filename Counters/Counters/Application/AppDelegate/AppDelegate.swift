//
//  AppDelegate.swift
//  Counters
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow()
        let presenter = WelcomeViewPresenter()
        let navigationController = UINavigationController()
        let welcomeViewController = WelcomeViewController(presenter: presenter)
        navigationController.viewControllers.append(welcomeViewController)
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

