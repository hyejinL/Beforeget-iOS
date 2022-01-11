//
//  FilterApplyButtonView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

import SnapKit
import Then

class FilterApplyButtonView: UIView {

    // MARK: - Properties
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 14
        $0.addArrangedSubviews([
            resetButton,
            applyButton])
    }
    
    /// 이미지 수정 요망
    public var resetButton = UIButton().then {
        $0.setImage(Asset.Assets.icnLittleStarBlack.image, for: .normal)
        $0.backgroundColor = .lightGray
    }
    
    public var applyButton = BDSButton().then {
        $0.text = "적용"
        $0.isDisabled = true
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
    
    private func configUI() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubviews([buttonStackView])
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(76)
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(76)
        }
    }
    
    // MARK: - Custom Method


}
