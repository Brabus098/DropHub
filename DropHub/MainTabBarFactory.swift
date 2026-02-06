//  MainTabBarFactory.swift

import UIKit
import Foundation

final class MainTabBarFactory {
    
    func make() -> UITabBarController {
        let rootController = UITabBarController()
        createTabBar(controller: rootController)
        configureViewControllers(rootController)
        return rootController
    }
    
    private func createTabBar(controller: UITabBarController) {
        controller.tabBar.tintColor = .black
        controller.tabBar.layer.borderColor = UIColor.specialBack.cgColor
        controller.tabBar.layer.masksToBounds = true
        controller.tabBar.layer.cornerRadius = 30
        controller.tabBar.layer.borderWidth = 2
    }
    
    private func makeTabBarItem(image: UIImage, tag: Int, bottomInset: CGFloat) -> UITabBarItem {
        let item = UITabBarItem(title: nil, image: image, tag: tag)
        item.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: bottomInset, right: 0)
        return item
    }
}

private extension MainTabBarFactory {
    
    func configureViewControllers(_ tabBarController: UITabBarController) {
        guard  let firstItemImage = UIImage(named: "TabBarFirst"),
               let inventoryImage = UIImage(named: "TabBarSecond") else { return }
        
        let firstVC = createGameController(with: firstItemImage)
        let secondVC = createInventoryController(with: inventoryImage)
        
        bind(gameController: firstVC, inventoryController: secondVC)
        
        tabBarController.viewControllers = [firstVC, secondVC]
        
    }
    
    func createGameController(with image: UIImage) -> GameViewController {
        
        let gameController = GameViewController()
        
        let model = GameDropAlgorithm(
            gameController: gameController,
            presentationController: gameController,
            gameLayoutController: gameController)
        
        gameController.gameFabric = model
        
        gameController.tabBarItem = makeTabBarItem(image: image, tag: 0, bottomInset: -50)
        return gameController
    }
    
    func createInventoryController(with image: UIImage) -> InventoryViewController {
        
        let fullScreenVC = FullImageController()
        let inventoryController = InventoryViewController(fullscreenVC: fullScreenVC)
        inventoryController.tabBarItem = makeTabBarItem(image: image, tag: 1, bottomInset: -40)
        
        return inventoryController
    }
}

private extension MainTabBarFactory {
    func bind(gameController: GameViewController, inventoryController: InventoryViewController) {
        
        gameController.gameFabric?.onObjectSelected = { [weak inventoryController] image in
            inventoryController?.updateGunImage(image: image)
        }
    }
}
