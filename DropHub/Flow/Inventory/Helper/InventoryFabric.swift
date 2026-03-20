//  InventoryFabric.swift

protocol InventoryFabricProtocol: AnyObject {
    func createData(imageArray: [WeaponsForPresent]) -> [InventoryModel]
}

final class InventoryFabric: InventoryFabricProtocol {
    private var inventoryWithDescriptionArray: [InventoryModel] = []
    
    /// Создает итоговый массив для отображения в инвентаре
    func createData(imageArray: [WeaponsForPresent]) -> [InventoryModel] {
        inventoryWithDescriptionArray = []
        for i in imageArray {
            let description = createDescription(type: i.type)
            let name = createImageName(for: i.type, name: i.name)
            
            inventoryWithDescriptionArray.append(InventoryModel(imageName: name, description: description, isVisible: true))
        }
        return inventoryWithDescriptionArray
    }
    
    /// Метод генерит описание к итоговым скинам в зависимости от типа оружия
    private func createDescription(type: WeaponsType) -> InventoryDescriptionModel {
        
        guard let description = MockDescriptionForGun.mockGunsArray.first(where: { $0.itemType == type }) else {
            return InventoryDescriptionModel(itemType: type, itemName: "Неизвестный ган", itemDescription: "Копит бабки к следующему раунду")
        }
        
        return InventoryDescriptionModel(
            itemType: type,
            itemName: description.itemName,
            itemDescription: description.itemDescription
        )
    }
    
    /// Метод генерит итоговое название картикнки в завсисимости от типа оружия
    private func createImageName(for type: WeaponsType, name: String) -> String {
        var result = ""
        switch type {
        case .AK47: result = "AK_"
        case .M4A1S: result = "M4A1S_"
        case .USP: result = "USP_"
        case .TEC: result = "TEC_"
        case .MAC: result = "MAC_"
        case .MP9: result = "MP9_"
        case .MP7: result = "MP7_"
        case .Agent: result = "Agent_"
        }
        
        return result + name
    }
}
