//
//  ReportDescriptionView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

class ReportDescriptionView: UIView {

    // MARK: - Properties
    
    var descriptionTitleLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.title3
    }
    
    var descriptionContentLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body1
        $0.numberOfLines = 4
        $0.textAlignment = .left
    }
    
    var descriptionTitle: String = "" {
        didSet {
            descriptionTitleLabel.text = "\(descriptionTitle)"
            descriptionTitleLabel.addLetterSpacing()
        }
    }
    
    var descriptionContent: String = "" {
        didSet {
            descriptionContentLabel.text = "\(descriptionContent)"
            descriptionContentLabel.addLineSpacing(spacing: 25)
            descriptionTitleLabel.addLetterSpacing()
        }
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
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubviews([descriptionTitleLabel, descriptionContentLabel])
        
        descriptionTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.top.equalToSuperview().inset(25)
        }
        
        descriptionContentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(11)
        }
    }
}
