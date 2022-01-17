//
//  AddItemCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class AddItemCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    private lazy var itemButton = UIButton().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.layer.borderColor = Asset.Colors.gray400.color.cgColor
        $0.layer.borderWidth = 1
        $0.makeRound(radius: 5)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.titleLabel?.font = BDSFont.body4
    }
    
    var item: String = ""
    var isSelectedItem: Bool = false
    
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
    }
    
    private func setupLayout() {
        contentView.addSubview(itemButton)
        
        itemButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    func config(_ itemTitle: String) {
        itemButton.setTitle(itemTitle, for: .normal)
    }
}
