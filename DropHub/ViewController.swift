//  ViewController.swift

import UIKit

final class ViewController: UIViewController {
    
    private var descriptionBlock = UIView()
    private var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let gunGalleryImageView = UIImageView()
//    private var gunGalleryArray = [UIImage(named: "Ak_Dima"),UIImage(named: "USP_Dima")]
    private var mainTextLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    private var secondGradientLayer = CAGradientLayer()
    private let endTextLabel = UILabel()

    private let mainImageView = UIImageView()
    private var timer: Timer?
    private var currentIndex = 0
    private let chooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("TAP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Impact", size: 60)
        button.setTitleColor(.imageBack, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
//
//        let buttonAction = UIAction(handler: {_ in
//            button.backgroundColor = .white
//            button.layer.borderColor = UIColor.secondGreen.cgColor
//            print("TAP")
//        })
        
        //button.addAction(buttonAction, for: .touchUpInside)
        
        button.backgroundColor = .firstGreen
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    var gunArray = [UIImage]()
    private var currentPhotoIndex = 0
    var onObjectSelected: ((UIImage) -> Void)?
    var numberOfStep = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpFirstView()
        setupDescriptionBlock()
        setupMainImage()
        setupMainLabel()
        setupTapButton()
        setupImageContainerWithGun()
        chooseButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = firstView.bounds
        secondGradientLayer.frame = gunGalleryImageView.bounds
    }
    
    private func setupMainImage(){
        mainImageView.image = UIImage(named: "Ak_47_main")
        mainImageView.contentMode = .scaleAspectFit // Важно!
        mainImageView.clipsToBounds = true
        //
        //                mainImageView.layer.borderWidth = 2
        //                mainImageView.layer.borderColor = UIColor.red.cgColor
        
        preSetView(newView: mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: descriptionBlock.topAnchor, constant: -110),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupMainLabel(){
        preSetView(newView: mainTextLabel)
        mainTextLabel.text = "Choose your gun"
        mainTextLabel.font = UIFont(name: "Impact", size: 50)
        mainTextLabel.textColor = .imageBack
        
//        mainTextLabel.layer.borderWidth = 2
//        mainTextLabel.layer.borderColor = UIColor.red.cgColor
        
        NSLayoutConstraint.activate([
            mainTextLabel.leadingAnchor.constraint(equalTo: descriptionBlock.leadingAnchor, constant: 20),
            mainTextLabel.topAnchor.constraint(equalTo: descriptionBlock.topAnchor, constant: -90),
            mainTextLabel.bottomAnchor.constraint(equalTo: descriptionBlock.bottomAnchor, constant: -50),
            mainTextLabel.trailingAnchor.constraint(equalTo: descriptionBlock.trailingAnchor, constant: -10),
            mainTextLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpFirstView(){
        preSetView(newView: firstView)
        
        gradientLayer.colors = [UIColor.secondGreen.cgColor, UIColor.firstGreen.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        firstView.layer.insertSublayer(gradientLayer, at: 0)
        
        NSLayoutConstraint.activate([
            firstView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            firstView.topAnchor.constraint(equalTo: view.topAnchor),
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupDescriptionBlock(){
        descriptionBlock.backgroundColor = .white
        preSetView(newView: descriptionBlock)
        
        NSLayoutConstraint.activate([
            descriptionBlock.topAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionBlock.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            descriptionBlock.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionBlock.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        descriptionBlock.layer.masksToBounds = true
        descriptionBlock.layer.cornerRadius = 30
    }
    private func setupTapButton(){
        preSetView(newView: chooseButton)
        
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: -150),
            chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            chooseButton.leadingAnchor.constraint(equalTo: descriptionBlock.leadingAnchor, constant: 80),
            chooseButton.trailingAnchor.constraint(equalTo: descriptionBlock.trailingAnchor, constant: -80)
        ])
    }
    private func setupImageContainerWithGun(){
        preSetView(newView: gunGalleryImageView)
        gunGalleryImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            gunGalleryImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            gunGalleryImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            gunGalleryImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            gunGalleryImageView.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: -30)
        ])
        
        gunGalleryImageView.layer.borderColor = UIColor.white.cgColor
        gunGalleryImageView.layer.backgroundColor = UIColor.specialBack.cgColor
        gunGalleryImageView.layer.cornerRadius = 10
        gunGalleryImageView.layer.borderWidth = 2
        gunGalleryImageView.clipsToBounds = true
    }
    
    private func setEndTextLabel(){
        endTextLabel.text = "Push on the 🎁\n and\n see what you've\n DONE"
        endTextLabel.numberOfLines = 4
        endTextLabel.textAlignment = .center
        endTextLabel.font = UIFont(name: "Impact", size: 40)
        endTextLabel.textColor = .white
        
        preSetView(newView: endTextLabel)
        
        NSLayoutConstraint.activate([
            endTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            endTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            endTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func preSetView(newView: UIView){
        self.view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func chooseGun(with name: String){
        for i in 1...10{
            if let newGunPhoto = UIImage(named: name + String(i)){
                gunArray.append(newGunPhoto)
                if i == 10{
                    print(newGunPhoto)
                }
            }
        }
        print("Загружено \(gunArray.count) изображений")
    }
    
    @objc private func buttonAction(_ sender: UIButton){
        print("Нажата")
        
        chooseButton.isEnabled = false
        
        self.resetPosition()

        switch self.numberOfStep {
        case 0:
            self.chooseGun(with: "AK_")
        case 1:
            self.chooseGun(with: "M4A1S_")
        case 2:
            self.chooseGun(with: "USP_")
        case 3:
            self.chooseGun(with: "TEC_")
        case 4:
            self.chooseGun(with: "MAC_")
        case 5:
            self.chooseGun(with: "MP9_")
        case 6:
            self.chooseGun(with: "MP7_")
        case 7:
            self.chooseGun(with: "Agent_")


        default:
            print("OVER the Guns")
            print(numberOfStep)
            return
        }
        numberOfStep += 1
        currentIndex = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.startTimer()
        }
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                     repeats: true) { _ in
            print("Показ изображения по индексу \(self.currentIndex)")
            self.gunGalleryImageView.image = self.gunArray[self.currentIndex] // Задаем значение с учетом currentIndex
            self.currentIndex = (self.currentIndex + 1) % self.gunArray.count // Обновляем currentIndex и предотвращаем выход за пределы массива
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10){ // заканчиваем через 10 сек на нужном значени
            self.stopTimer()
            
            switch self.numberOfStep {
        
            case 1: self.self.addAkGun()
            case 2: self.addM41S()
            case 3: self.addUSP()
            case 4: self.addTEC()
            case 5: self.addMAC()
            case 6: self.addMP9()
            case 7: self.addMP7()
            case 8: self.addAgent()
                
            default:
                print("Нет нужного кейса в startTimer, numberOfStep - \(self.numberOfStep)")
                return
            }
        }
    }
    
    private func addAkGun(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.mainImageView.image = UIImage(named: "M4A1S_main")
        }
        onButton()
    }
    
    private func addM41S(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.mainImageView.image = UIImage(named: "USP_main")
        }
        onButton()
    }
    
    private func addUSP(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.mainImageView.image = UIImage(named: "TEC_main")
            self.mainImageView.topAnchor.constraint(equalTo: self.descriptionBlock.topAnchor, constant: -130).isActive = true
            self.view.layoutIfNeeded()
        }
        onButton()
    }
    
    private func addTEC(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.mainImageView.image = UIImage(named: "MAC_main")
        }
        onButton()
    }
    
    private func addMAC(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.mainImageView.image = UIImage(named: "MP9_main")
        }
        onButton()
    }
    
    private func addMP9(){
        UIView.animate(withDuration: 2) {
            self.doAnimateAndSendImage()
            self.mainImageView.image = UIImage(named: "MP7_main")
        }
        onButton()
    }
    
    private func addMP7(){
        UIView.animate(withDuration: 1) {
            self.doAnimateAndSendImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            UIView.animate(withDuration: 2) {
                self.mainImageView.image = UIImage(named: "Agent_main")
                self.mainImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                self.mainImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -200).isActive = true
                self.view.layoutIfNeeded()
            }
        }
        onButton()
    }
    
    private func addAgent(){
        UIView.animate(withDuration: 1) {
            self.doAnimateAndSendImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            UIView.animate(withDuration: 1) {
                self.setEndTextLabel()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            UIView.animate(withDuration: 1) {
                self.showAlert()
            }
        }
    }
    
    private func resetPosition() {
        UIView.animate(withDuration: 2) {
            self.gunGalleryImageView.transform = .identity
            self.gunGalleryImageView.layer.opacity = 1
        }
    }
    
    private func doAnimate(){
        self.gunGalleryImageView.transform = CGAffineTransform(translationX: 0, y: 250)
        self.gunGalleryImageView.layer.opacity = 0
    }
    private func fix(){
        // Фикс бага с добавлением следующей картинки
        if self.currentIndex == 0 {
            guard let image = self.gunArray.last else { return }
            print("Отправляется изображение под индексом - \(self.gunArray.last)")
            self.onObjectSelected?(image)
            self.gunArray.removeAll()
        
        } else {
            let image = self.gunArray[self.currentIndex - 1]
            print("Отправляется изображение под индексом - \(self.currentIndex - 1)")
            self.onObjectSelected?(image)
            self.gunArray.removeAll()
        }
    }
    
    private func doAnimateAndSendImage(){
        self.doAnimate()
        self.fix()
    }
    
    private func onButton(){
        self.chooseButton.isEnabled = true
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Поздравялю c днем рождения!",
                                      message: "Подарки можно найти в соседней вкладке",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Спасибо 😋", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
}

