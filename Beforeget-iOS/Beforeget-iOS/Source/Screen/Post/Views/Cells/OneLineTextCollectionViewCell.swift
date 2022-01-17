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
    
    private lazy var onelineLabel = UILabel().then {
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.gray200.color
    }
    
    // MARK: - InitUI
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            let borderColor = isSelected ? Asset.Colors.black200.color.cgColor : Asset.Colors.gray200.color.cgColor
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = borderColor
            contentView.makeRound(radius: 20)
            
            let textColor = isSelected ? Asset.Colors.black200.color : Asset.Colors.gray200.color
            onelineLabel.textColor = textColor
        }
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = Asset.Colors.white.color
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Asset.Colors.gray200.color.cgColor
        contentView.makeRound(radius: 20)
    }
    
    private func setupLayout() {
        addSubview(onelineLabel)
        
        onelineLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    public func config(oneline: String) {
        onelineLabel.text = oneline
    }
}
