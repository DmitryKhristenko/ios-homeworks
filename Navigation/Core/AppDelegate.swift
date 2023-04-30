//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var coreDataStack: CoreDataStack = .init(modelName: "PostEntity")
    
    static let sharedAppDelegate: AppDelegate = {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
            }
            return delegate
        }()
    
    private func createFeedViewController() -> UINavigationController {
        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    
    private func createLoginViewController() -> UINavigationController {
        let logInViewController = LoginViewController()
        logInViewController.title = "Profile"
        logInViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        let navigationController = UINavigationController(rootViewController: logInViewController)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = UIColor(red: 113/255, green: 201/255, blue: 206/255, alpha: 1.0)
        tabBarController.viewControllers = [createFeedViewController(), createLoginViewController()]
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
