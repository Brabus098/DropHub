//  GameLogic.swift

import UIKit

final class GameLogic: GameLogicProtocol {
    
    let gunMainImageArray: [UIImage]
    var currentFrameIndex = 0 // Текущий кадр анимации (0-19)
    var currentWeaponIndex = 0 // // Индекс текущего оружия (0-7)
    var gunPhotoArray: [[UIImage]] = []
    
    init(gunMainImageArray: [UIImage]) {
        self.gunMainImageArray = gunMainImageArray
    }
    
    /// Метод для итерации внутри массива
    func timerTrick() -> Bool {
        currentFrameIndex += 1
        
        if currentFrameIndex >= 20 {
            currentFrameIndex = 0
            return true // нужно вызвать pauseGame
        }
        return false
    }
    
    /// Метод для показа следующего оружия
    func moveToNextWeapon() -> Bool {
        currentWeaponIndex += 1
        
        if currentWeaponIndex >= gunMainImageArray.count {
            return true // игра закончена
        }
        return false
    }
    
    deinit {
        print("GameLogic deinit")
    }
}
