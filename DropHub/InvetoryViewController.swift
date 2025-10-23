//
//  InvetoryViewController.swift
//  DimaApp
//
//  Created by Владимир on 15.06.2025.
//

import UIKit

class InventoryViewController: UIViewController {

    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2  // Поддержка двух строк
        label.text = "Welcome \nDima Inventory"
        label.textColor = .imageBack
        
        label.font = UIFont(name: "Impact", size: 40) ?? UIFont.systemFont(ofSize: 60, weight: .bold)
        
        // Отключаем autoresizing mask для использования Auto Layout
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
    
    func updateGunImage(image:UIImage) {
        inventoryArray.append(image)
        addImage()
    }

    private func addImage(){
   
        contentView.subviews.forEach { $0.removeFromSuperview() }

        var backImage: UIImageView?
        
        for (index, newImage) in inventoryArray.enumerated(){
            
            var actualImageView = UIImageView(image: newImage)
            actualImageView.image = newImage
            actualImageView.isUserInteractionEnabled = true // Важно!
            actualImageView.tag = index // Сохраняем индекс для идентификации
            
            // Добавляем распознаватель касаний
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            actualImageView.addGestureRecognizer(tapGesture)
            
            var label = UILabel()
            label.font = UIFont(name: "Impact", size: 60)
            label.textColor = .white
            
            var descriptionLabel = UILabel()
            descriptionLabel.font = UIFont(name: "Impact", size: 20)
            descriptionLabel.textAlignment = .left
            descriptionLabel.numberOfLines = 4
            descriptionLabel.textColor = .white
            
            contentView.addSubview(actualImageView)
            contentView.addSubview(label)
            contentView.addSubview(descriptionLabel)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            actualImageView.translatesAutoresizingMaskIntoConstraints = false
            actualImageView.contentMode = .scaleAspectFit
            
            // Общие настройки изображения
            NSLayoutConstraint.activate([
                actualImageView.widthAnchor.constraint(equalToConstant: 250), // Фиксированная ширина
                actualImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
                actualImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                label.bottomAnchor.constraint(equalTo: actualImageView.topAnchor, constant: -20),
                label.centerYAnchor.constraint(equalTo: actualImageView.centerYAnchor),
                label.heightAnchor.constraint(equalToConstant: 50),
                
                descriptionLabel.centerYAnchor.constraint(equalTo: actualImageView.centerYAnchor),
                descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
             ])
            
            // Настойка промежуточных значений
            if let oldView = backImage {
                switch index {
                case 1: label.text = "M4ька"
                    descriptionLabel.text = "Особые свойства:\n позволяет почувствовать\n себя хитменом"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 70).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
                    
                case 2: label.text = "USPик"
                    descriptionLabel.text = "Особые свойства:\n дает заряд уверенности\n на 2 раунда"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 70).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
                    
                case 3: label.text = "TEC"
                    descriptionLabel.text = "Особые свойства:\n дает заряд уверенности\n на 3 раунда"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 110).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
                    
                case 4: label.text = "🍟10"
                    descriptionLabel.text = "Особые свойства:\n выручает когда сложно"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 100).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true

                case 5: label.text = "MPшка"
                    descriptionLabel.text = "Особые свойства:\n копит бабки\n к следующему раунду"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 55).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
                    
                case 6: label.text = "MP7"
                    descriptionLabel.text = "Особые свойства:\n позволяет убить 3-х\n игроков на банане"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 100).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
                    
                case 7: label.text = "ТЕЛО"
                    descriptionLabel.text = "Особые свойства:\n устрашает врага,\n позволяет не отдаваться\n безвольно"
                    label.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 90).isActive = true
                    descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 140).isActive = true
                    descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
                    
                default:
                    label.text = "ХЗGun"
                    descriptionLabel.text = "Что за пушка страшная?"

                }
                
                actualImageView.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 25).isActive = true
                descriptionLabel.leadingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: 30).isActive = true

            } else {
                
                // Настройка первого текста
                label.text = "AK-47"
                
                descriptionLabel.text = "Особые свойства:\n позволяет не отдавать раунд,\n который нужен"
                descriptionLabel.numberOfLines = 3
                
                // Настройка первого изображения
                actualImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive = true
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
                descriptionLabel.topAnchor.constraint(equalTo: actualImageView.topAnchor, constant: 80).isActive = true
                descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 80).isActive = true
            }
            
            // Добавляем правый констрейнт для крайнего изображения
            if index == inventoryArray.count - 1{
                actualImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
            }
            

            
            // Обновляем значения
            contentView.layoutIfNeeded()
            backImage = actualImageView
        }
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView,
              let image = imageView.image else { return }
        
        let index = imageView.tag // Получаем сохраненный индекс
        
        // Создаем контроллер для полноэкранного просмотра
        let fullscreenVC = FullImageController()
        fullscreenVC.setImage(image)
        
        // Показываем контроллер
        present(fullscreenVC, animated: true)
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
