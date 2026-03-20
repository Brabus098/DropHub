//  GameViewControllerProtocol.swift

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    func setGunGallery(image: UIImage)
    func setMain(image: UIImage)
    func doAnimate()
    func onButton()
    func stopAllButtonAnimations()
    func needOpenGunAtInventory(index: Int)
}

