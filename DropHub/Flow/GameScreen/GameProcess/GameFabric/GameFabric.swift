//  GameFabric.swift

import UIKit

final class GameFabric: GameFabricProtocol {
    private let arrayWithPresent: [WeaponsForPresent]
    private var gunPhotoArray = [[UIImage]]()
    
    init(arrayWithPresent: [WeaponsForPresent]) {
        self.arrayWithPresent = arrayWithPresent
    }
    
    /// Создает итоговый массив для рулетки с учетом оружия которое должно выпасть
    /// - Returns: Двухмерный массив с итоговыми изображениями для каждого из видов скинов
    func createMockGunsWithPresent() -> [[UIImage]]{
        
        for i in arrayWithPresent {
            switch i.type.rawValue {
            case 0:
                addGunPhoto(withType: "AK_", presentGunName: i.name)
            case 1:
                addGunPhoto(withType: "M4A1S_", presentGunName: i.name)
            case 2:
                addGunPhoto(withType: "USP_", presentGunName: i.name)
            case 3:
                addGunPhoto(withType: "TEC_", presentGunName: i.name)
            case 4:
                addGunPhoto(withType: "MAC_", presentGunName: i.name)
            case 5:
                addGunPhoto(withType: "MP9_", presentGunName: i.name)
            case 6:
                addGunPhoto(withType: "MP7_", presentGunName: i.name)
            case 7:
                addGunPhoto(withType: "Agent_", presentGunName: i.name)
                
            default:
                print("[Game DropAlgorithm]: Error. OVER the Guns")
            }
        }
        return gunPhotoArray
    }
    
    /// Наполняет  массив
    private func addGunPhoto(withType name: String, presentGunName: String) {
        var localArray: [UIImage] = []
        for i in 1...9 {
            if let newGunPhoto = UIImage(named: name + String(i)){
                localArray.append(newGunPhoto)
            }
        }
        localArray.append(UIImage(named: name + presentGunName) ?? UIImage())
        gunPhotoArray.append(localArray)
    }
    
    deinit {
        print("GameFabric deinit")
    }
}
