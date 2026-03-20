//  MockGameViewController.swift

@testable import DropHub
import UIKit

final class MockGameViewController: GameViewControllerProtocol, GameViewControllerPresentationProtocol, GameLayoutProtocol {
    
    var showAlertCalled = false
    var presentTextLabelCalled = false
    var changeMainImageLeftAndRightConstraintCalled = false
    var setGunGalleryCalled = false
    var setMainCalled = false
    var doAnimateCalled = false
    var onButtonCalled = false
    var stopAllButtonAnimationsCalled = false
    var needOpenGunCalled = false
    var needOpenGunIndex: Int?
    
    func showAlert() { showAlertCalled = true }
    func presentTextLabel() { presentTextLabelCalled = true }
    func changeMainImageLeftAndRightConstraint() { changeMainImageLeftAndRightConstraintCalled = true }
    
    func setGunGallery(image: UIImage) {
        setGunGalleryCalled = true
    }
    
    func setMain(image: UIImage) {
        setMainCalled = true
    }
    
    func doAnimate() { doAnimateCalled = true }
    func onButton() { onButtonCalled = true }
    func stopAllButtonAnimations() { stopAllButtonAnimationsCalled = true }
    
    func needOpenGunAtInventory(index: Int) {
        needOpenGunCalled = true
        needOpenGunIndex = index
    }
}


