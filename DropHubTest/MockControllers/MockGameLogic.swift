//  MockGameLogic.swift

@testable import DropHub
import UIKit

final class MockGameLogic: GameLogicProtocol {
    var currentFrameIndex: Int = 0
    var currentWeaponIndex: Int = 1
    var gunPhotoArray: [[UIImage]] = []
    var gunMainImageArray: [UIImage] = []
    func timerTrick() -> Bool { true }
    func moveToNextWeapon() -> Bool { true }
}
