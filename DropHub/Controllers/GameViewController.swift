//  ViewController.swift

import UIKit

final class GameViewController: UIViewController {
    
    private var descriptionBlock = UIView()
    private let gunGalleryImageView = UIImageView()
    private var mainTextLabel = UILabel()
    private let endTextLabel = UILabel()
    private let mainImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private var secondGradientLayer = CAGradientLayer()
    
    private lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let chooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("TAP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Impact", size: 60)
        button.setTitleColor(.imageBack, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        
        button.backgroundColor = .firstGreen
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    var gameFabric: GameDropAlgorithmProtocol?
    
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
    
    private func setupMainImage() {
        mainImageView.image = UIImage(named: "Ak_47_main")
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.clipsToBounds = true
        
        //           mainImageView.layer.borderWidth = 2
        //           mainImageView.layer.borderColor = UIColor.red.cgColor
        
        preSetView(newView: mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: descriptionBlock.topAnchor, constant: -110),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mainImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupMainLabel() {
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
    
    private func setupTapButton() {
        preSetView(newView: chooseButton)
        
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: mainTextLabel.bottomAnchor, constant: -150),
            chooseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            chooseButton.leadingAnchor.constraint(equalTo: descriptionBlock.leadingAnchor, constant: 80),
            chooseButton.trailingAnchor.constraint(equalTo: descriptionBlock.trailingAnchor, constant: -80)
        ])
    }
    
    private func setupImageContainerWithGun() {
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
    
    @objc private func buttonAction(_ sender: UIButton) {
        chooseButton.isEnabled = false
        
        self.resetPosition()
        gameFabric?.startGame()
    }
    
    private func resetPosition() {
        UIView.animate(withDuration: 2) {
            self.gunGalleryImageView.transform = .identity
            self.gunGalleryImageView.layer.opacity = 1
        }
    }
}

// MARK: Updating Ui function by GameDropAlgorithm
extension GameViewController: GameViewControllerProtocol {
    
    func setGunGallery(image: UIImage) {
        DispatchQueue.main.async {
            self.gunGalleryImageView.image = image
        }
    }
    
    func setMain(image: UIImage) {
        DispatchQueue.main.async {
            self.mainImageView.image = image
        }
    }
    
    func doAnimate() {
        self.gunGalleryImageView.transform = CGAffineTransform(translationX: 0, y: 250)
        self.gunGalleryImageView.layer.opacity = 0
    }
    
    func onButton() {
        self.chooseButton.isEnabled = true
    }
}

extension GameViewController: GameLayoutProtocol {
    
    func changeMainImageTopConstraint() {
        self.mainImageView.topAnchor.constraint(equalTo: self.descriptionBlock.topAnchor, constant: -130).isActive = true
        self.view.layoutIfNeeded()
    }
    
    func changeMainImageLeftAndRightConstraint() {
        self.mainImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mainImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -200).isActive = true
        self.view.layoutIfNeeded()
    }
}

// MARK: Presentation function
extension GameViewController: GameViewControllerPresentationProtocol {
    
    func presentTextLabel() {
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
    
    func showAlert() {
        let alert = UIAlertController(title: "Поздравялю c днем рождения!",
                                      message: "Подарки можно найти в соседней вкладке",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Спасибо 😋", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension GameViewController {
    
    private func preSetView(newView: UIView){
        self.view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
