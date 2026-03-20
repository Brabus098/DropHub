//  GameDropAlgorithmProtocol.swift

import UIKit

protocol GameDropAlgorithmProtocol: AnyObject {
    var lastGunInArray: UIImage? { get }
    var gunPhotoArrayCount: Int { get }
    var isPresentedAllCases: Bool { get }
    func startGame()
    func timerTrick()
    func pauseBetweenGame()
    func updateWeaponAnimationFrames(_ array: [[UIImage]])
}
