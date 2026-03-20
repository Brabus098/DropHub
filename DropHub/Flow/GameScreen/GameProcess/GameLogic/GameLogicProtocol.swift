//  GameLogicProtocol.swift

import UIKit

protocol GameLogicProtocol: AnyObject {
    var currentFrameIndex: Int { get set }
    var currentWeaponIndex: Int { get set }
    var gunPhotoArray: [[UIImage]] { get set }
    var gunMainImageArray: [UIImage] { get }
    
    func timerTrick() -> Bool // true если нужно вызвать pauseGame
    func moveToNextWeapon() -> Bool // true если игра закончена
}
