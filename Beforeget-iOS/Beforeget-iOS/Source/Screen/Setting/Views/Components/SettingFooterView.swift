//
//  SettingFooterView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

class SettingFooterView: UIView {

    // MARK: - Properties

    private var infoButton = UIButton().then {
        $0.setImage(Asset.Assets.btnInfo.image, for: .normal)
        $0.contentMode = .scaleAspectFit
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
    }
    
    private func setupLayout() {
        addSubviews([infoButton])
        
        infoButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 195 : 152)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(30)
        }
    }
}
