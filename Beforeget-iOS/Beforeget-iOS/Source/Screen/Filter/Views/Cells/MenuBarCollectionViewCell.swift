//
//  MenuBarCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

class MenuBarCollectionViewCell: UICollectionViewCell,
                                    UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            menuLabel.textColor = isSelected ?
            Asset.Colors.black200.color :
            Asset.Colors.gray300.color
        }
    }
    
    public let menuLabel = UILabel().then {
        $0.font = BDSFont.title6
        $0.textColor = Asset.Colors.gray300.color
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func setupLayout() {
        contentView.addSubview(menuLabel)
        
        menuLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
