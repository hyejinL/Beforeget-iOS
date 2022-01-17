//
//  SettingTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class SettingTableViewCell: UITableViewCell,
                            UITableViewRegisterable {
    
    // MARK: - Properties
        
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray400.color
    }
    
    public let menuLabel = UILabel().then {
        $0.font = BDSFont.body1
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .left
    }
    
    public let nextButton = UIButton().then {
        $0.setImage(Asset.Assets.btnNext.image, for: .normal)
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubviews([lineView,
                                 menuLabel,
                                 nextButton])
        
        lineView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(2)
            make.width.height.equalTo(44)
        }
    }
    
    // MARK: - Set Data
    
    public func setData(_ data: String) {
        menuLabel.text = data
    }
}
