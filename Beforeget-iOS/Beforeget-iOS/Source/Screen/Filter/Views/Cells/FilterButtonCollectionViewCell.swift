//
//  FilterButtonCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

class FilterButtonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var menu: Filter? {
        didSet {
            guard let menu = menu else { return }
            cellLabel.text = menu.filterMenu
        }
    }
    
    private var menuButton = UIButton().then {
        $0.setImage(Asset.Assets.boxFilterActive.image, for: .selected)
        $0.setImage(Asset.Assets.boxFilterInactive.image, for: .normal)
    }

    public var cellLabel = UILabel().then {
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.gray300.color
    }
        
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configuUI() {
        cellLabel.textColor = isSelected ?
        Asset.Colors.black200.color :
        Asset.Colors.gray300.color
        
        menuButton.layer.borderColor = isSelected ?
        Asset.Colors.black200.color.cgColor :
        Asset.Colors.gray300.color.cgColor
    }
    
    private func setupLayout() {
        contentView.addSubview(menuButton)
        menuButton.addSubview(cellLabel)
        
        menuButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(37)
        }
        
        cellLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
