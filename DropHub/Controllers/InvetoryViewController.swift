//  InvetoryViewController.swift

import UIKit

final class InventoryViewController: UIViewController {
    
    let fullscreenVC: FullImageControllerProtocol?
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Welcome \nDima Inventory"
        label.textColor = .imageBack
        
        label.font = UIFont(name: "Impact", size: 40) ?? UIFont.systemFont(ofSize: 60, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var inventoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBack
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.firstGreen.cgColor
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 2
        return view
    }()
    
    private var inventoryArray = [UIImage]()
    private var mainImageView = UIImageView()
    private var imageScrollView = UIScrollView()
    private var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWelcomeLabel()
        setupInventoryView()
        setupScroll()
    }
    
    init(fullscreenVC: FullImageControllerProtocol?) {
        self.fullscreenVC = fullscreenVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWelcomeLabel(){
        preSetView(newView: welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupInventoryView(){
        preSetView(newView: inventoryView)
        
        NSLayoutConstraint.activate([
            inventoryView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            inventoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            inventoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            inventoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    private func setupScroll(){
        
        inventoryView.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.isPagingEnabled = true
        
        // Настройка ContentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.addSubview(contentView)
        
        // Констрейнты для ScrollView
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: inventoryView.topAnchor),
            imageScrollView.bottomAnchor.constraint(equalTo: inventoryView.bottomAnchor),
            imageScrollView.leadingAnchor.constraint(equalTo: inventoryView.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: inventoryView.trailingAnchor)
        ])
        // Констрейнты для ContentView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: imageScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: imageScrollView.heightAnchor),
            contentView.widthAnchor.constraint(greaterThanOrEqualTo: imageScrollView.widthAnchor)
        ])
    }
    
    private func preSetView(newView: UIView){
        self.view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

// Methods calls SceneDelegate
extension InventoryViewController {
    
    func updateGunImage(image:UIImage) {
        inventoryArray.append(image)
        addImage()
    }
    
    private func addImage(){
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        var backImage: UIImageView?
        
        for (index, newImage) in inventoryArray.enumerated(){
            
            let actualImageView = createBaseImageView(with: newImage, andWith: index)
            let label = createNameLabelForGun()
            let descriptionLabel = createDescriptionLabelForGun()
            
            addBaseSetupFor(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel)
            
            // Настойка промежуточных значений
            if let oldView = backImage {
                switch index {
                case 1:
                    setupForMFourCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel,oldImage: oldView)
                case 2:
                    setupForUSPCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel, oldImage: oldView)
                case 3:
                    setupForTECCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel, oldImage: oldView)
                    
                case 4: setupForMACCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel, oldImage: oldView)
                    
                case 5: setupForMPCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel, oldImage: oldView)
                    
                case 6: setupForMPSevenCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel, oldImage: oldView)
                    
                case 7: setupForBodyCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel, oldImage: oldView)
                    
                default:
                    label.text = "ХЗGun"
                    descriptionLabel.text = "Что за пушка страшная?"
                }
                actualImageView.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 25).isActive = true
                descriptionLabel.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 30).isActive = true
                
            } else {
                setupForAkCard(image: actualImageView, nameLabel: label, descriptionLabel: descriptionLabel)
            }
            
            // Добавляем правый констрейнт для крайнего изображения
            if index == inventoryArray.count - 1 {
                actualImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
            }
            
            // Обновляем значения
            contentView.layoutIfNeeded()
            backImage = actualImageView
        }
    }
    
    private func setupForAkCard(image: UIImageView, nameLabel: UILabel
                                ,descriptionLabel: UILabel) {
        nameLabel.text = "AK-47"
        
        descriptionLabel.text = "Особые свойства:\n позволяет не отдавать раунд,\n который нужен"
        descriptionLabel.numberOfLines = 3
        
        // Настройка первого изображения
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupForMFourCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text = "M4ька"
        descriptionLabel.text = "Особые свойства:\n позволяет почувствовать\n себя хитменом"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 70).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupForUSPCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text = "USPик"
        descriptionLabel.text = "Особые свойства:\n дает заряд уверенности\n на 2 раунда"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 70).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupForTECCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text = "TEC"
        descriptionLabel.text = "Особые свойства:\n дает заряд уверенности\n на 3 раунда"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 110).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    private func setupForMACCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text = "🍟10"
        descriptionLabel.text = "Особые свойства:\n выручает когда сложно"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 100).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupForMPCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text = "MPшка"
        descriptionLabel.text = "Особые свойства:\n копит бабки\n к следующему раунду"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 55).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupForMPSevenCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text =  "MP7"
        descriptionLabel.text = "Особые свойства:\n позволяет убить 3-х\n игроков на банане"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 100).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 80).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    private func setupForBodyCard(image: UIImageView, nameLabel: UILabel, descriptionLabel: UILabel, oldImage: UIImageView) {
        nameLabel.text =  "ТЕЛО"
        descriptionLabel.text = "Особые свойства:\n устрашает врага,\n позволяет не отдаваться\n безвольно"
        nameLabel.leadingAnchor.constraint(equalTo: oldImage.trailingAnchor, constant: 90).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 140).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView,
              let image = imageView.image else { return }
        
        // Создаем контроллер для полноэкранного просмотра
        fullscreenVC?.setImage(image)
        
        present(fullscreenVC as! UIViewController, animated: true)
    }
    
    private func createBaseImageView(with image: UIImage, andWith index:Int) -> UIImageView {
        let baseImageView = UIImageView(image: image)
        baseImageView.image = image
        baseImageView.isUserInteractionEnabled = true
        baseImageView.contentMode = .scaleAspectFit
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        baseImageView.addGestureRecognizer(tapGesture)
        return baseImageView
    }
    
    private func createNameLabelForGun() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Impact", size: 60)
        label.textColor = .white
        return label
    }
    
    private func createDescriptionLabelForGun() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Impact", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 4
        label.textColor = .white
        return label
    }
    
    private func addBaseSetupFor(image: UIImageView, nameLabel: UILabel
                                 ,descriptionLabel: UILabel) {
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        // Общие настройки изображения
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 250),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
