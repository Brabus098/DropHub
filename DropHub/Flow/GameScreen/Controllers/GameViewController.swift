//  ViewController.swift

import UIKit
import SnapKit

final class GameViewController: UIViewController {
    
    private let gunGalleryImageView = UIImageView()
    private let endTextLabel = UILabel()
    private let mainImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private var secondGradientLayer = CAGradientLayer()
    private var descriptionBlock = UIView()
    private var mainTextLabel = UILabel()
    private var arrayWithPresent: [WeaponsForPresent]
    
    private lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    weak var delegate: InventoryProtocol?
    
    private let pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("TAP", for: .normal)
        button.titleLabel?.font = UIFont(name: "Impact", size: 60)
        button.setTitleColor(.imageBack, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        
        button.backgroundColor = .firstGreen
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        return button
    }()
    
    var gameFabric: GameFabricProtocol?
    var gameManager: GameDropAlgorithmProtocol?
    
    init(arrayWithPresent: [WeaponsForPresent], delegate: InventoryProtocol? = nil) {
        self.arrayWithPresent = arrayWithPresent
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let frames = gameFabric?.createMockGunsWithPresent() {
            gameManager?.updateWeaponAnimationFrames(frames)
        }
        
        setUpFirstView()
        setupDescriptionBlock()
        setupMainImage()
        setupMainLabel()
        setupImageContainerWithGun()
        pushButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        addConstraint()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = firstView.bounds
        secondGradientLayer.frame = gunGalleryImageView.bounds
    }
    
    deinit {
        print("GameViewController deinit")
    }
    
    // MARK: Background views
    private func setUpFirstView(){
        view.preSetView(newView: firstView)
        
        gradientLayer.colors = [UIColor.secondGreen.cgColor, UIColor.firstGreen.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        firstView.layer.insertSublayer(gradientLayer, at: 0)
        
        firstView.constraintEdges(to: view)
    }
    
    private func setupDescriptionBlock(){
        view.preSetView(newView: descriptionBlock)
        descriptionBlock.backgroundColor = .white
        descriptionBlock.layer.masksToBounds = true
        descriptionBlock.layer.cornerRadius = 30
        
        descriptionBlock.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY)
            make.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
        }
    }
    
    private func addConstraint() {
        view.preSetView(newView: gunGalleryImageView)
        view.preSetView(newView: mainImageView)
        view.preSetView(newView: mainTextLabel)
        view.preSetView(newView: pushButton)
        
        gunGalleryImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(160)
        }
        mainImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(160)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.trailing.equalTo(gunGalleryImageView)
            make.leading.equalTo(gunGalleryImageView)
        }
        
        pushButton.snp.makeConstraints { make in
            make.top.equalTo(mainTextLabel.snp.bottom)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func setupMainImage() {
        mainImageView.image = UIImage(named: "Ak_47_main")
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.clipsToBounds = true
    }
    
    private func setupMainLabel() {
        mainTextLabel.text = "Choose your gun"
        mainTextLabel.font = UIFont(name: "Impact", size: 50)
        mainTextLabel.textColor = .imageBack
    }
    
    private func setupImageContainerWithGun() {
        gunGalleryImageView.contentMode = .scaleAspectFit
        gunGalleryImageView.clipsToBounds = true
        gunGalleryImageView.backgroundColor = .clear
        
        gunGalleryImageView.layer.cornerRadius = 10
        gunGalleryImageView.layer.borderWidth = 2
        gunGalleryImageView.layer.borderColor = UIColor.white.cgColor
        gunGalleryImageView.layer.backgroundColor = UIColor.specialBack.cgColor
        
        gunGalleryImageView.image = UIImage(named: "CtLogo")
        gunGalleryImageView.tintColor = .white
    }
    
    private func backGunGalleryPosition(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 2 ,animations: {
            self.gunGalleryImageView.transform = .identity
            self.gunGalleryImageView.layer.opacity = 1
        }) { _ in
            completion()
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
    
    func needOpenGunAtInventory(index: Int){
        DispatchQueue.main.async {
            self.delegate?.openGun(withImage: index)
        }
    }
    
    func doAnimate() {
        self.gunGalleryImageView.transform = CGAffineTransform(translationX: 0, y: 250)
        self.gunGalleryImageView.layer.opacity = 0
    }
}

// MARK: Button
extension GameViewController {
    
    func onButton() {
        self.gunGalleryImageView.image = UIImage(named: "CtLogo")
        
        DispatchQueue.main.async {
            self.backGunGalleryPosition { [weak self] in
                guard let self = self else { return }
                
                self.pushButton.isEnabled = true
                self.pushButton.layer.removeAllAnimations()
                self.startPulseAnimation()
                self.scheduleStopPulseAnimation()
            }
        }
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        pushButton.isEnabled = false
        sender.setTitleColor(.white, for: .normal)
        
        stopAllButtonAnimations()
        animateButtonTap(sender)
    }
    
    // MARK: - Private Methods
    
    private func startPulseAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.autoreverse, .repeat, .allowUserInteraction],
                       animations: {
            self.pushButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
    }
    
    private func scheduleStopPulseAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.stopPulseAnimation()
        }
    }
    
    private func stopPulseAnimation() {
        pushButton.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.3) {
            self.pushButton.transform = .identity
        }
    }
    
    func stopAllButtonAnimations() {
        pushButton.layer.removeAllAnimations()
        pushButton.transform = .identity
    }
    
    private func animateButtonTap(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = .identity
            }) { _ in
                sender.setTitleColor(.imageBack, for: .normal)
                self.gameManager?.startGame()
            }
        }
    }
}

extension GameViewController: GameLayoutProtocol {
    func changeMainImageLeftAndRightConstraint() {
        UIView.animate(withDuration: 0.3) {
            self.mainImageView.transform = CGAffineTransform(translationX: -100, y: 0)
        }
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
        
        view.preSetView(newView: endTextLabel)
        endTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Поздравялю c днем рождения!",
                                      message: "Подарки можно найти в соседней вкладке",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Спасибо 😋", style: .cancel) {_ in
            if let tabBar = self.tabBarController {
                tabBar.selectedIndex = 1
            }
            
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
