//  InvetoryViewController.swift

import UIKit
import SnapKit

final class InventoryViewController: UIViewController {
    
    private let fabric: InventoryFabricProtocol?
    private let arrayWithPresent: [WeaponsForPresent]
    private var inventoryArray: [InventoryModel] = []
    private var inventoryCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: UICollectionViewFlowLayout())
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = "Увы, \nинвенторя \nпока нет"
        label.textColor = .imageBack
        label.font = UIFont(name: "Impact", size: 40) ?? UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .left
        
        return label
    }()
    
    private var emptyViewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hasntSkins")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private var descriptionEmptyViewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Вот бы кто-нибудь дропнул..."
        label.textColor = .imageBack
        label.font = UIFont(name: "Impact", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    let fullscreenVC: FullImageControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setWelcomeLabelConstraint()
        setupCollection()
        showEmptyView()
    }
    
    init(fullscreenVC: FullImageControllerProtocol?,
         arrayWithPresent: [WeaponsForPresent],
         fabric: InventoryFabricProtocol?) {
        self.fullscreenVC = fullscreenVC
        self.arrayWithPresent = arrayWithPresent
        self.fabric = fabric
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.preSetView(newView: welcomeLabel)
    }
    
    private func showEmptyView() {
        view.preSetView(newView: emptyViewImage)
        view.preSetView(newView: descriptionEmptyViewLabel)
        
        emptyViewImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(15)
        }
        
        descriptionEmptyViewLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyViewImage.snp.bottom)
            make.leading.equalTo(emptyViewImage)
            make.trailing.equalTo(emptyViewImage)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        if inventoryArray.isEmpty {
            emptyViewImage.isHidden = false
        }
    }
    
    private func setWelcomeLabelConstraint() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).offset(50)
            make.height.equalTo(150)
        }
    }
}

extension InventoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        CGSize(width: collectionView.bounds.width,
               height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        inventoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
        
        cell.setElement(inventoryItem: inventoryArray[indexPath.row])
        return cell
    }
    
    private func setupCollection() {
        if let layout = inventoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .zero
        }
        inventoryCollectionView.showsHorizontalScrollIndicator = false
        inventoryCollectionView.isPagingEnabled = true
        inventoryCollectionView.register(InventoryCell.self, forCellWithReuseIdentifier: "InventoryCell")
        
        inventoryCollectionView.delegate = self
        inventoryCollectionView.dataSource = self
        
        view.preSetView(newView: inventoryCollectionView)
        
        inventoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.leading.equalTo(view).offset(50)
            make.trailing.equalTo(view).offset(-50)
        }
    }
}

extension InventoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = UIImage(named: inventoryArray[indexPath.row].imageName) else { return }
        
        guard let controller = fullscreenVC as? FullImageController else { return }
        
        controller.setImage(image)
        
        present(controller, animated: true)
    }
}

extension InventoryViewController: InventoryProtocol {
    
    func openGun(withImage index: Int) {
        let range = 0...index
        let slice = Array(arrayWithPresent[range])
        let newArray = fabric?.createData(imageArray: slice) ?? []
        
        inventoryArray = newArray
        
        removeEmptyView()
        
        DispatchQueue.main.async {
            self.inventoryCollectionView.reloadData()
        }
    }
    
    private func removeEmptyView() {
        emptyViewImage.isHidden = true
        welcomeLabel.text = "Welcome \nto Inventory" // Должно задаваться при стартовой настройке пользователем
        descriptionEmptyViewLabel.isHidden = true
    }
}


