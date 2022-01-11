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
    
    public var isCellSelected: Bool = false {
        didSet {
            isSelected = !isSelected
            configuUI()
        }
    }
    
    public var isStarHidden: Bool = false {
        didSet {
            starImageView.isHidden = isStarHidden ?
            true : false
        }
    }
    
    private var menuButton = UIButton(type: .system).then {
        $0.makeRound()
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.gray300.color.cgColor
    }
    
    private lazy var cellStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.addArrangedSubviews([starImageView, cellLabel])
    }

    public var cellLabel = UILabel().then {
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.gray300.color
    }
    
    private lazy var starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLittleStarBlack.image
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
        menuButton.addSubview(cellStackView)
        
        menuButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(37)
        }
        
        cellStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.centerX.equalToSuperview()
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        cellLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
