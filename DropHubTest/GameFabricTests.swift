import XCTest
@testable import DropHub

final class GameFabricTests: XCTestCase {
    
    var sut: GameFabric!
    
    override func setUp() {
        super.setUp()
        let mockWeapons = [
            WeaponsForPresent(name: "10", type: .M4A1S),
            WeaponsForPresent(name: "10", type: .MAC),
            WeaponsForPresent(name: "10", type: .USP)
        ]
        sut = GameFabric(arrayWithPresent: mockWeapons)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCreateMockGunsWithPresent_ReturnsNonEmptyArray() {
        let result = sut.createMockGunsWithPresent()
        XCTAssertFalse(result.isEmpty)
    }
    
    func testCreateMockGunsWithPresent_ReturnsCorrectCount() {
        let result = sut.createMockGunsWithPresent()
        XCTAssertEqual(result.count, 3)
    }
    
    func testCreateMockGunsWithPresent_EachArrayHasTenImages() {
        let result = sut.createMockGunsWithPresent()
        
        for (index, gunImages) in result.enumerated() {
            XCTAssertEqual(gunImages.count, 10,
                           "Ошибка в индексе \(index)")
        }
    }
    
    func testCreateMockGunsWithPresent_ImagesAreNotNil() {
        let result = sut.createMockGunsWithPresent()
        for (i, gunImages) in result.enumerated() {
            for (j, image) in gunImages.enumerated() {
                XCTAssertNotNil(image,
                                "Изображение [\(i)][\(j)] == nil")
            }
        }
    }
    
    func testReturnResult() {
        let result = sut.createMockGunsWithPresent()
        for (index, gunImages) in result.enumerated() {
            print("I = \(gunImages)")
            XCTAssertEqual(gunImages.count, 10,
                           "Ошибка в индексе \(index)")
        }
    }
    
    func testCreateMockGunsWithPresent_WithEmptyArray_ReturnsEmptyArray() {
        let emptyFabric = GameFabric(arrayWithPresent: [])
        let result = emptyFabric.createMockGunsWithPresent()
        print("result - \(result)")
        
        var counter = 0
        
        for _ in result {
            counter += 1
        }
        
        XCTAssertEqual(counter, 0,
                       "Ошибка при пустом массиве")
    }
}
