//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let appDelegate = AppDelegate()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        window.rootViewController = appDelegate.createTabBarController() // initial view controller.
        window.makeKeyAndVisible()
        self.window = window
    }
    
}
