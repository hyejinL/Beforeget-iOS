//
//  PostModalReviewCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class OneLineTextCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    private lazy var oneLineLabel = UILabel().then {
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.gray200.color
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(Asset.Assets.btnReviewDelete.image, for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(touchupDeleteButton), for: .touchUpInside)
    }
    
    private lazy var oneLineStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 4
        $0.addArrangedSubviews([oneLineLabel, deleteButton])
    }
    
    var deleteOneLine: (() -> ())?
    
    override var isSelected: Bool {
        didSet {
            let borderColor = isSelected ? Asset.Colors.black200.color.cgColor : Asset.Colors.gray200.color.cgColor
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = borderColor
            contentView.makeRound(radius: 20)
            
            let textColor = isSelected ? Asset.Colors.black200.color : Asset.Colors.gray200.color
            oneLineLabel.textColor = textColor
            
            if isSelected {
                NotificationCenter.default.post(name: Notification.Name.didSelectOneLine, object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name.didDeselectOneLine, object: nil)
            }
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = Asset.Colors.white.color
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray200.color.cgColor
        contentView.makeRound(radius: 20)
    }
    
    private func setupLayout() {
        addSubview(oneLineStackView)
        
        oneLineStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    public func config(oneline: String) {
        oneLineLabel.text = oneline
    }
    
    public func configPostOneLineCell() {
        contentView.makeRound(radius: 17)
        contentView.layer.borderColor = Asset.Colors.black200.color.cgColor
        contentView.backgroundColor = Asset.Colors.white.color
        oneLineLabel.textColor = Asset.Colors.black200.color
        deleteButton.isHidden = false
    }
    
    //MARK: - @objc
    
    @objc func touchupDeleteButton() {
        deleteOneLine?()
    }
}
