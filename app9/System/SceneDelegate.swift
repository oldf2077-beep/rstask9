//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            fatalError("LOL, be careful, drink some water")
        }
        let itemsController = ItemsViewControllerInstance.shared
        let itemsTab = UITabBarItem(
               title: "Items",
               image: UIImage(systemName: "square.grid.2x2"),
               selectedImage: UIImage(systemName: "square.grid.2x2")
        )
        
        let settingsController = SettingsViewController()
        let settingsTab = UITabBarItem(
               title: "Settings",
               image: UIImage(systemName: "gear"),
               selectedImage: UIImage(systemName: "gear")
        )
        
        let itemsNavController = NavigationController(rootViewController: itemsController)
        let settingsNavController = NavigationController(rootViewController: settingsController)
        
        itemsNavController.tabBarItem = itemsTab
        settingsNavController.tabBarItem = settingsTab

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [itemsNavController, settingsNavController]
        tabBarController.tabBar.tintColor = .red
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.backgroundColor = .white
        
        
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
}

