//
//  ReviewTagCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class ReviewTagCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
        
    public var reviewLabel = UILabel().then {
        $0.font = BDSFont.body6
        $0.textColor = Asset.Colors.white.color
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reviewLabel.text = nil
    }

    // MARK: - InitUI
    
    private func setupLayout() {
        contentView.addSubview(reviewLabel)
        
        reviewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Custom Method
    
    func config(_ data: String, color: UIColor, fontColor: UIColor) {
        reviewLabel.text = data
        contentView.backgroundColor = color
        reviewLabel.textColor = fontColor
    }
}
