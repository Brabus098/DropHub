//  InventoryCell.swift

import UIKit
import SnapKit

final class InventoryCell: UICollectionViewCell {
    
    private lazy var gunName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Impact", size: 60)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gunImage: UIImageView = {
        let baseImageView = UIImageView()
        baseImageView.contentMode = .scaleAspectFit
        
        return baseImageView
    }()
    
    private var gunDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Impact", size: 22)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .specialBack
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 30
    }
    
    private func setData(image: String,
                         nameLabel: String,
                         descriptionLabel: String) {
        gunImage.image = UIImage(named: image)
        gunName.text = nameLabel
        gunDescription.text = descriptionLabel
    }
    
    private func setupLayout() {
        
        contentView.preSetView(newView: gunImage)
        contentView.preSetView(newView: gunName)
        contentView.preSetView(newView: gunDescription)
        
        gunName.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(50)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
        }
        
        gunImage.snp.makeConstraints { make in
            make.width.equalTo(contentView).multipliedBy(0.8)
            make.height.equalTo(contentView).multipliedBy(0.4)
            make.center.equalTo(contentView)
        }
        
        gunDescription.snp.makeConstraints { make in
            make.top.equalTo(gunImage.snp.bottom)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-15)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        gunName.text = nil
        gunImage.image = nil
        gunDescription.text = nil
        contentView.isHidden = false
    }
}

extension InventoryCell {
    func setElement(inventoryItem: InventoryModel) {
        setData(image: inventoryItem.imageName,
                nameLabel: inventoryItem.description.itemName,
                descriptionLabel: inventoryItem.description.itemDescription)
        contentView.isHidden = !inventoryItem.isVisible
    }
}
