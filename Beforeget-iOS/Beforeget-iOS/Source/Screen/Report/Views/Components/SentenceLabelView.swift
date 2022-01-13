//
//  SentenceLabelView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class SentenceLabelView: UIView {
    
    // MARK: - Properties
    
    private var sentenceLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.body8
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitUI
    
    private func configUI() {
        self.layer.borderColor = Asset.Colors.green100.color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
    }
    
    private func setupLayout() {
        addSubview(sentenceLabel)
        
        sentenceLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(9)
            $0.top.bottom.equalToSuperview().inset(4)
        }
    }
}
