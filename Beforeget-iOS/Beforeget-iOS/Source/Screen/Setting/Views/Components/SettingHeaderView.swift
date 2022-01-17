//
//  SettingHeaderView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class SettingHeaderView: UIView {

    // MARK: - Properties
    
    private var nicknameLabel = UILabel().then {
        $0.text = "후릐안녕"
        $0.font = BDSFont.title1
        $0.textColor = Asset.Colors.black200.color
    }
    
    private var emailLabel = UILabel().then {
        $0.text = "heerucan@apple.com"
        $0.font = BDSFont.body6
        $0.textColor = Asset.Colors.gray200.color
    }
    
    private var editButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.setImage(Asset.Assets.btnNameEdit.image, for: .normal)
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
        backgroundColor = Asset.Colors.white.color
        nicknameLabel.addLetterSpacing()
        emailLabel.addLetterSpacing()
        nicknameLabel.addLineSpacing(spacing: 34)
        emailLabel.addLineSpacing(spacing: 23)
    }
    
    private func setupLayout() {
        addSubviews([nicknameLabel,
                     emailLabel,
                     editButton])
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 52 : 42)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(51)
        }
        
        editButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIScreen.main.hasNotch ? 70 : 78)
            make.leading.equalTo(nicknameLabel.snp.trailing)
            make.width.height.equalTo(40)
        }
    }
}
