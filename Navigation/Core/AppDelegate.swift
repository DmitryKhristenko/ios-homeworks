//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private func createFeedViewController() -> UINavigationController {
        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc.richtext"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    private func createProfileViewController() -> UINavigationController {
        let logInViewController = LogInViewController()
        logInViewController.title = "Profile"
        logInViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "studentdesk"), tag: 1)
        return UINavigationController(rootViewController: logInViewController)
    }
     func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = UIColor(red: 113/255, green: 201/255, blue: 206/255, alpha: 1.0)
        tabBarController.viewControllers = [createFeedViewController(), createProfileViewController()]
        return tabBarController
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
