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
       
        guard let windowScene = (scene as? UIWindowScene),
                 let firstItemImage = UIImage(named: "TabBarFirst"),
                 let inventoryImage = UIImage(named: "TabBarSecond") else { return }
           
           window = UIWindow(windowScene: windowScene)
        
        let rootController = UITabBarController()
        let packController = GameViewController()
        let fullScreenVC = FullImageController()
        
        let gameFabric = GameDropAlgorithm(gameController: packController, presentationController: packController, gameLayoutController: packController)
        packController.gameFabric = gameFabric
        
        packController.tabBarItem = UITabBarItem(title: nil, image: firstItemImage, tag: 0)
        packController.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom:-50, right: 0)
        
        
        let inventoryController = InventoryViewController(fullscreenVC: fullScreenVC)
        
        inventoryController.tabBarItem = UITabBarItem(title: nil, image: inventoryImage, tag: 1)
        inventoryController.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom:-40, right: 0)
        
     
        gameFabric.onObjectSelected = { [weak inventoryController] image in
            inventoryController?.updateGunImage(image: image)
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
}

