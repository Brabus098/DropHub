//  MainTabBarFactory.swift

import UIKit

final class MainTabBarFactory {
    
    private let arrayWithPresent = [WeaponsForPresent(name: "10", type: .AK47),
                                    WeaponsForPresent(name: "10", type: .M4A1S),
                                    WeaponsForPresent(name: "10", type: .USP),
                                    WeaponsForPresent(name: "10", type: .TEC),
                                    WeaponsForPresent(name: "10", type: .MAC),
                                    WeaponsForPresent(name: "10", type: .MP9),
                                    WeaponsForPresent(name: "10", type: .MP7),
                                    WeaponsForPresent(name: "10", type: .Agent)] // должен меняться на реальные данные введенные пользователем главном экране
    
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
        let gameManager = GameManager(gameController: firstVC,
                                      presentationController: firstVC,
                                      gameLayoutController: firstVC)
        
        firstVC.delegate = secondVC
        firstVC.gameManager = gameManager
        
        tabBarController.viewControllers = [firstVC, secondVC]
    }
    
    func createGameController(with image: UIImage) -> GameViewController {
        
        let gameController = GameViewController(arrayWithPresent: arrayWithPresent)
        let fabric = GameFabric(arrayWithPresent: arrayWithPresent)
        
        gameController.gameFabric = fabric
        gameController.tabBarItem = makeTabBarItem(image: image, tag: 0, bottomInset: -50)
        return gameController
    }
    
    func createInventoryController(with image: UIImage) -> InventoryViewController {
        let fabric = InventoryFabric()
        let fullScreenVC = FullImageController()
        let inventoryController = InventoryViewController(fullscreenVC: fullScreenVC, arrayWithPresent: arrayWithPresent, fabric: fabric)
        inventoryController.tabBarItem = makeTabBarItem(image: image, tag: 1, bottomInset: -40)
        
        return inventoryController
    }
}
