//  GameManagerTests.swift

import XCTest
@testable import DropHub

final class GameManagerTests: XCTestCase {
    var mockLogic: GameLogicProtocol!
    var manager: GameManager!
    
    override func setUp() {
        super.setUp()
        let mockWeapons = [UIImage(named: "AK_1")!]
        
        let secondMockWeapons = [[UIImage(named: "AK_1")!,
                                  UIImage(named: "AK_2")!,
                                  UIImage(named: "AK_3")!,
                                  UIImage(named: "AK_4")!,
                                  UIImage(named: "AK_5")!,
                                  UIImage(named: "AK_6")!,
                                  UIImage(named: "AK_7")!,
                                  UIImage(named: "AK_8")!,
                                  UIImage(named: "AK_9")!,
                                  UIImage(named: "AK_10")!]]
        let gameViewController = MockGameViewController()
        mockLogic = MockGameLogic()  // Нужно создать MockGameLogic!
        manager = GameManager(gameController: gameViewController, presentationController: gameViewController, gameLayoutController:gameViewController, logic: mockLogic)
        manager.updateWeaponAnimationFrames(secondMockWeapons)
    }
    
    override func tearDown() {
        super.tearDown()
        mockLogic = nil
        manager = nil
    }
    
    func testtimerTrick_LastImage_HasIndex_10() {
        //given
        mockLogic.currentWeaponIndex = 0
        mockLogic.currentFrameIndex = 9
        
        // When
        manager.timerTrick()
        
        print("mockLogic.currentFrameIndex - \(mockLogic.currentFrameIndex)")
        //Then
        XCTAssertNotNil(manager.lastGunInArray)
        if let result = manager.lastGunInArray {
            XCTAssertEqual(result, UIImage(named: "AK_10"))
        }
    }
    
    func testCountOfWeapons() {
        //given
        let array = [[UIImage(named: "AK_1")!]]
        manager.updateWeaponAnimationFrames(array)
        
        //When
        let result = manager.gunPhotoArrayCount
        
        //Then
        XCTAssertEqual(result, 1)
    }
    
    func testIsShowing_Present() {
        // Given
        mockLogic.currentWeaponIndex = 2
        
        let expectation = XCTestExpectation(description: "pauseBetweenGame completed")
        
        // When
        manager.pauseBetweenGame()
        XCTAssertFalse(self.manager.isPresentedAllCases)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            guard let self = self else { return }
            
            // Then
            XCTAssertTrue(self.manager.isPresentedAllCases)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}

