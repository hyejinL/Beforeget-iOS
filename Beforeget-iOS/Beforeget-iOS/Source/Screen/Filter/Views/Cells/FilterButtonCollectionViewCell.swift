//
//  FilterButtonCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

import SnapKit
import Then

class FilterButtonCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            print("isSelected",isSelected)
            configUI()
        }
    }
    
    private var menuView = UIView().then {
        $0.makeRound()
        $0.layer.borderColor = Asset.Colors.gray300.color.cgColor
        $0.layer.borderWidth = 1
        $0.backgroundColor = .white
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        cellLabel.textColor = isSelected ?
        Asset.Colors.black200.color :
        Asset.Colors.gray300.color
        
        menuView.layer.borderColor = isSelected ?
        Asset.Colors.black200.color.cgColor :
        Asset.Colors.gray300.color.cgColor
    }
    
    private func setupLayout() {
        contentView.addSubview(menuView)
        menuView.addSubview(cellLabel)
        
        menuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(37)
        }
        
        cellLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
