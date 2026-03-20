//  GameDropAlgoritm.swift

import UIKit

final class GameManager: GameDropAlgorithmProtocol {
    
    private enum Constants {
        static let timerInterval = 0.5
        static let animationDuration = 2.0
        static let mainImageAnimationDuration = 1.0
    }
    
    private let logic: GameLogicProtocol
    private var timer: Timer?
    
    let gunMainImageArray: [UIImage]
    var lastGunInArray: UIImage? = nil
    var isPresentedAllCases = false
    
    var gunPhotoArray: [[UIImage]] {
        get { logic.gunPhotoArray }
        set { logic.gunPhotoArray = newValue }
    }
    
    var currentFrameIndex: Int {
        get { logic.currentFrameIndex }
        set { logic.currentFrameIndex = newValue }
    }
    
    var currentWeaponIndex: Int {
        get { logic.currentWeaponIndex }
        set { logic.currentWeaponIndex = newValue }
    }
    
    var gunPhotoArrayCount: Int {
        gunPhotoArray.count
    }
    
    weak var gameController: GameViewControllerProtocol?
    weak var presentationController: GameViewControllerPresentationProtocol?
    weak var gameLayoutController: GameLayoutProtocol?
    
    
    init(gameController: GameViewControllerProtocol,
         presentationController: GameViewControllerPresentationProtocol,
         gameLayoutController: GameLayoutProtocol,
         logic: GameLogicProtocol? = nil) {
        
        self.gameController = gameController
        self.presentationController = presentationController
        self.gameLayoutController = gameLayoutController
        
        let images = [
            UIImage(named: "Ak_47_main"),
            UIImage(named: "M4A1S_main"),
            UIImage(named: "USP_main"),
            UIImage(named: "TEC_main"),
            UIImage(named: "MAC_main"),
            UIImage(named: "MP9_main"),
            UIImage(named: "MP7_main"),
            UIImage(named: "Agent_main")
        ].compactMap { $0 }
        
        self.gunMainImageArray = images
        
        self.logic = logic ?? GameLogic(gunMainImageArray: images)
    }
    
    deinit {
        print("GameManager deinit")
    }
    
    /// Метод начинающий игру
    func startGame() {
        resetGameState()
        DispatchQueue.main.async {
            self.startGameTimer()
        }
    }
    
    /// Метод добалевения массива с призами выбранный пользователем
    func updateWeaponAnimationFrames(_ array: [[UIImage]]) {
        gunPhotoArray = array
    }
    
    /// Метод помогающий итерироваться внутри двухмерного массива со всеми наборами
    private func resetGameState() {
        currentFrameIndex = 0 // можно юзать для тестов
    }
}

// MARK: Timer
extension GameManager {
    /// Метод запускающий игру и таймер
    private func startGameTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timerInterval,
                                     repeats: true) { _ in
            self.timerTrick()
        }
    }
    
    /// Метод содержащий алгоритм выпадения предмета
    func timerTrick() {
        
        // Показываем ихображение
        let actualArrayCount = gunPhotoArray[currentWeaponIndex].count
        let actualImage = gunPhotoArray[currentWeaponIndex][currentFrameIndex % actualArrayCount]
        lastGunInArray = actualImage
        gameController?.setGunGallery(image: actualImage)
        
        // Обновляем счетчики
        let needPause = logic.timerTrick()
        
        if needPause {
            pauseBetweenGame()
        }
    }
    
    /// Метод  проверяющий необходимость продложения игры
    func pauseBetweenGame() {
        DispatchQueue.main.async {
            self.stopTimer()
            self.doAnimateAndSendImageIndex { [weak self] in
                guard let self = self else { return }
                // Проверяем, не закончилась ли игра
                let gameComplete = self.logic.moveToNextWeapon()
                
                if gameComplete {
                    self.stopAllAnimations()
                    self.presentAnimation()
                    isPresentedAllCases = true
                } else {
                    self.animateNewMainImage {
                        self.gameController?.onButton()
                    }
                }
            }
        }
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}

// MARK: Animation
extension GameManager {
    ///  Метод остановка анимации при переходе на другой таб после окончания игры
    private func stopAllAnimations() {
        gameController?.stopAllButtonAnimations()
        UIView.setAnimationsEnabled(false)
        UIView.setAnimationsEnabled(true)
    }
    
    /// Метод для показа поздравительного алерта и анимации
    private func presentAnimation() {
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            self?.gameLayoutController?.changeMainImageLeftAndRightConstraint()
            self?.presentationController?.presentTextLabel()
        } completion: { _ in
            self.presentationController?.showAlert()
        }
    }
    
    /// Метод для отправления выбранного индекса который нужно показать в инвентаре
    private func doAnimateAndSendImageIndex(completion: @escaping () -> Void) {
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.gameController?.doAnimate()
            self?.gameController?.needOpenGunAtInventory(index: self?.currentWeaponIndex ?? 0)
        }, completion: { _ in
            completion()
        })
    }
    
    /// Метод для смены основной картинки с разыгрываемым оружием на главном табе
    private func animateNewMainImage(completion: @escaping () -> Void) {
        UIView.animate(withDuration: Constants.mainImageAnimationDuration, animations: { [weak self] in
            guard let self = self else { return }
            let image = self.gunMainImageArray[self.currentWeaponIndex]
            self.gameController?.setMain(image: image)
        }, completion: { _ in
            completion()
        })
    }
}
