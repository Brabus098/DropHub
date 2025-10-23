//
//  SceneDelegate.swift
//  DimaApp
//
//  Created by Владимир on 12.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let scene = (scene as? UIWindowScene), let firstItemImage = UIImage(named: "TabBarFirst"), let inventoryImage = UIImage(named: "TabBarSecond") else { return }
        window?.windowScene = scene
        
        let rootController = UITabBarController()
        
        let packController = ViewController()
        packController.tabBarItem = UITabBarItem(title: nil, image: firstItemImage, tag: 0)
        packController.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom:-50, right: 0)
        
        
        let inventoryController = InventoryViewController()
        inventoryController.tabBarItem = UITabBarItem(title: nil, image: inventoryImage, tag: 1)
        inventoryController.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom:-40, right: 0)
        
        // 2. Настраиваем связь ДО добавления в TabBarController
             packController.onObjectSelected = { [weak inventoryController] image in
                 inventoryController?.updateGunImage(image: image)
                 //rootController.selectedIndex = 1 // Переключаем на второй таб
             }
        
        rootController.viewControllers = [packController, inventoryController]
        rootController.tabBar.tintColor = .black
        rootController.tabBar.layer.borderColor = UIColor.specialBack.cgColor
        rootController.tabBar.layer.masksToBounds = true
        rootController.tabBar.layer.cornerRadius = 30
        rootController.tabBar.layer.borderWidth = 2
                
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

