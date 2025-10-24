//  GameDropAlgoritm.swift

import UIKit

final class GameDropAlgorithm: GameDropAlgorithmProtocol {
    
    var gunPhotoArray = [UIImage]()
    private var numberOfStep = 0
    private var currentIndex = 0
    private var timer: Timer?
    
    weak var gameController: GameViewControllerProtocol?
    weak var presentationController: GameViewControllerPresentationProtocol?
    weak var gameLayoutController: GameLayoutProtocol?
    
    var onObjectSelected: ((UIImage) -> Void)?
    
    init(gameController: GameViewControllerProtocol, presentationController: GameViewControllerPresentationProtocol, gameLayoutController: GameLayoutProtocol) {
        self.gameController = gameController
        self.presentationController = presentationController
        self.gameLayoutController = gameLayoutController
    }
    
    func startGame() {
        
        switch self.numberOfStep {
        case 0:
            addGunPhotoInArray(with: "AK_")
        case 1:
            addGunPhotoInArray(with: "M4A1S_")
        case 2:
            addGunPhotoInArray(with: "USP_")
        case 3:
            addGunPhotoInArray(with: "TEC_")
        case 4:
            addGunPhotoInArray(with: "MAC_")
        case 5:
            addGunPhotoInArray(with: "MP9_")
        case 6:
            addGunPhotoInArray(with: "MP7_")
        case 7:
            addGunPhotoInArray(with: "Agent_")
            
        default:
            print("[Game DropAlgorithm]: Error. OVER the Guns")
            return
        }
        
        numberOfStep += 1
        currentIndex = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.startGameTimer()
        }
    }
    
    private func addGunPhotoInArray(with name: String) {
        for i in 1...10{
            if let newGunPhoto = UIImage(named: name + String(i)){
                gunPhotoArray.append(newGunPhoto)
                if i == 10{
                    print(newGunPhoto)
                }
            }
        }
        print("Загружено \(gunPhotoArray.count) изображений")
    }
    
    private func startGameTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                     repeats: true) { _ in
            print("Показ изображения по индексу \(self.currentIndex)")
            
            self.gameController?.setGunGallery(image: self.gunPhotoArray[self.currentIndex])// Задаем значение с учетом currentIndex
            self.currentIndex = (self.currentIndex + 1) % self.gunPhotoArray.count // Обновляем currentIndex и предотвращаем выход за пределы массива
        }
        stopGameTimer()
    }
    
    private func stopGameTimer(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // заканчиваем через 10 сек на нужном значени
            self.stopTimer()
            
            switch self.numberOfStep {
                
            case 1: self.addAkGun()
            case 2: self.addM41S()
            case 3: self.addUSP()
            case 4: self.addTEC()
            case 5: self.addMAC()
            case 6: self.addMP9()
            case 7: self.addMP7()
            case 8: self.addAgent()
                
            default:
                print("[GameDropAlgorithm]: stopGameTimer - Нет нужного кейса в startTimer, numberOfStep - \(self.numberOfStep)")
                return
            }
        }
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    private func addAkGun(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.gameController?.setMain(image: UIImage(named: "M4A1S_main") ?? UIImage())
            
        }
        gameController?.onButton()
    }
    
    private func addM41S(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.gameController?.setMain(image: UIImage(named: "USP_main") ?? UIImage())
        }
        gameController?.onButton()
    }
    
    private func addUSP(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.gameController?.setMain(image: UIImage(named: "TEC_main") ?? UIImage())
            self.gameLayoutController?.changeMainImageTopConstraint()
        }
        gameController?.onButton()
    }
    
    private func addTEC(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.gameController?.setMain(image: UIImage(named: "MAC_main") ?? UIImage())
        }
        gameController?.onButton()
    }
    
    private func addMAC(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.gameController?.setMain(image: UIImage(named: "MP9_main") ?? UIImage())
        }
        gameController?.onButton()
    }
    
    private func addMP9(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.gameController?.setMain(image: UIImage(named: "MP7_main") ?? UIImage())
        }
        gameController?.onButton()
    }
    
    private func addMP7(){
        UIView.animate(withDuration: 1) {
            self.doAnimateAndSendImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            UIView.animate(withDuration: 2) {
                self.gameController?.setMain(image: UIImage(named: "Agent_main") ?? UIImage())
                self.gameLayoutController?.changeMainImageLeftAndRightConstraint()
            }
        }
        gameController?.onButton()
    }
    
    private func addAgent(){
        UIView.animate(withDuration: 1) {
            self.doAnimateAndSendImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1) {
                self.presentationController?.presentTextLabel()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 1) {
                self.presentationController?.showAlert()
            }
        }
    }
    
    private func doAnimateAndSendImage(){
        self.gameController?.doAnimate()
        self.fix()
    }
}

extension GameDropAlgorithm {
    
    private func fix(){
        // Фикс бага с добавлением следующей картинки
        if self.currentIndex == 0 {
            guard let image = self.gunPhotoArray.last else { return }
            print("Отправляется изображение под индексом - \(String(describing: self.gunPhotoArray.last))")
            self.onObjectSelected?(image)
            self.gunPhotoArray.removeAll()
            
        } else {
            let image = self.gunPhotoArray[self.currentIndex - 1]
            print("Отправляется изображение под индексом - \(self.currentIndex - 1)")
            self.onObjectSelected?(image)
            self.gunPhotoArray.removeAll()
        }
    }
}
