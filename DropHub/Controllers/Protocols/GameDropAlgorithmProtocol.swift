//  GameDropAlgorithmProtocol.swift

import UIKit

protocol GameDropAlgorithmProtocol: AnyObject {
    func startGame()
     var onObjectSelected: ((UIImage) -> Void)? { get set }
}
