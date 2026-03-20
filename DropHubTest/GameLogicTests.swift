//  GameLogicTests.swift

import XCTest
@testable import DropHub

final class GameLogicTests: XCTestCase {
    var logic: GameLogic!
    
    override func setUp() {
        super.setUp()
        let mockWeapons = [UIImage(named: "AK_1")!,
                           UIImage(named: "AK_2")!,
                           UIImage(named: "AK_3")!,
                           UIImage(named: "AK_4")!,
                           UIImage(named: "AK_5")!,
                           UIImage(named: "AK_6")!,
                           UIImage(named: "AK_7")!,
                           UIImage(named: "AK_8")!,
                           UIImage(named: "AK_9")!,
                           UIImage(named: "AK_10")!]
        
        logic = GameLogic(gunMainImageArray: mockWeapons)
    }
    
    override func tearDown() {
        logic = nil
        super.tearDown()
    }
    
    // MARK: - Тесты timerTrick
    
    func testTimerTrick_IncrementsFrameIndex() {
        // Given
        logic.currentFrameIndex = 5
        
        // When
        let result = logic.timerTrick()
        
        // Then
        XCTAssertEqual(logic.currentFrameIndex, 6)
        XCTAssertFalse(result)
    }
    
    func testTimerTrick_WhenFrameIndexIs19_ResetsToZero() {
        // Given
        logic.currentFrameIndex = 19
        
        // When
        let result = logic.timerTrick()
        
        // Then
        XCTAssertEqual(logic.currentFrameIndex, 0)
        XCTAssertTrue(result)
    }
    
    func testTimerTrick_20Calls_CycleCompletes() {
        // Given
        logic.currentFrameIndex = 0
        
        // When & Then
        for callNumber in 1...20 {
            let result = logic.timerTrick()
            
            if callNumber < 20 {
                XCTAssertEqual(logic.currentFrameIndex, callNumber)
                XCTAssertFalse(result)
            } else {
                XCTAssertEqual(logic.currentFrameIndex, 0)
                XCTAssertTrue(result)
            }
        }
    }
    
    // MARK: - Тесты moveToNextWeapon
    
    func testMoveToNextWeapon_IncrementsWeaponIndex() {
        // Given
        logic.currentWeaponIndex = 0
        
        // When
        let result = logic.moveToNextWeapon()
        
        // Then
        XCTAssertEqual(logic.currentWeaponIndex, 1)
        XCTAssertFalse(result)
    }
    
    func testMoveToNextWeapon_WhenLastWeapon_ReturnsTrue() {
        // Given
        logic.currentWeaponIndex = 9 // последний в массиве из 10
        
        // When
        let result = logic.moveToNextWeapon()
        
        // Then
        XCTAssertEqual(logic.currentWeaponIndex, 10)
        XCTAssertTrue(result)
    }
    
    // MARK: - Интеграционные тесты
    
    func testFullWeaponCycle() {
        // Given
        logic.currentWeaponIndex = 0
        let totalWeapons = logic.gunMainImageArray.count // 10
        
        // When - проходим все оружия
        for weaponIndex in 0..<10 {
            // Проходим 20 кадров для каждого оружия
            for frame in 0..<20 {
                let result = logic.timerTrick()
                
                if frame < 19 {
                    XCTAssertEqual(logic.currentFrameIndex, frame + 1)
                    XCTAssertFalse(result)
                } else {
                    XCTAssertEqual(logic.currentFrameIndex, 0)
                    XCTAssertTrue(result)
                }
            }
            
            // Переходим к следующему оружию
            if weaponIndex < 9 {
                let gameComplete = logic.moveToNextWeapon()
                XCTAssertEqual(logic.currentWeaponIndex, weaponIndex + 1)
                XCTAssertFalse(gameComplete)
            }
        }
        
        // Then - после последнего оружия
        let finalGameComplete = logic.moveToNextWeapon()
        XCTAssertEqual(logic.currentWeaponIndex, totalWeapons) // Индекс вышел за пределы
        XCTAssertTrue(finalGameComplete)
    }
}
