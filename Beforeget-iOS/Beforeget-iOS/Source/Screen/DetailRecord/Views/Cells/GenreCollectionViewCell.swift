//
//  GenreCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class GenreCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    public let genreLabel = UILabel().then {
        $0.font = BDSFont.body4
        $0.textColor = Asset.Colors.black200.color
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
    
    public func configUI() {
        contentView.backgroundColor = Asset.Colors.gray400.color
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    public func setupLayout() {
        contentView.addSubview(genreLabel)
        
        genreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview().inset(6)
        }
    }
    
    // MARK: - Custom Method
    
    public func setData(_ data: String) {
        genreLabel.text = data
    }
}
