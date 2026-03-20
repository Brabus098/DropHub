import XCTest
@testable import DropHub

final class InventoryFabricTests: XCTestCase {
    
    var sut: InventoryFabric!
    var arrayWithPresent: [WeaponsForPresent] = []
    
    override func setUp() {
        super.setUp()
        
        arrayWithPresent = [
            WeaponsForPresent(name: "10", type: .AK47),
            WeaponsForPresent(name: "10", type: .M4A1S),
            WeaponsForPresent(name: "10", type: .USP),
            WeaponsForPresent(name: "10", type: .TEC),
            WeaponsForPresent(name: "10", type: .MAC),
            WeaponsForPresent(name: "10", type: .MP9),
            WeaponsForPresent(name: "10", type: .MP7),
            WeaponsForPresent(name: "10", type: .Agent)
        ]
        
        sut = InventoryFabric()
    }
    
    override func tearDown() {
        sut = nil
        arrayWithPresent = []
        super.tearDown()
    }
    
    func testCheck_createdArray_isNotNil() {
        let result = sut.createData(imageArray: arrayWithPresent)
        XCTAssertNotNil(result)
    }
    
    func testPrint_createdArray() {
        let result = sut.createData(imageArray: arrayWithPresent)
        for item in result {
            print("Готовый item: /n\(item.imageName) /n\(item.description)")
            XCTAssertNotNil(item)
        }
    }
    
    func testArray_ReturnsCorrectCount() {
        let result = sut.createData(imageArray: [WeaponsForPresent(name: "10", type: .USP)])
        XCTAssertEqual(result.count, 1)
    }
    
    func testArray_IsEmpty() {
        let result = sut.createData(imageArray: [])
        var counter = 0
        
        for _ in result{
            counter += 1
        }
        
        XCTAssertEqual(counter, 0,
                       "Ошибка при пустом массиве")
    }
}
