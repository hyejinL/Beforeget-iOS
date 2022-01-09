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
    
    private lazy var typeLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.title3
        $0.addLetterSpacing()
    }
    
    private lazy var typeDescriptionLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body1
        $0.numberOfLines = 4
        $0.textAlignment = .left
        $0.addLetterSpacing()
    }
    
    var type: String = "" {
        didSet {
            typeLabel.text = "\(type)"
        }
    }
    
    var typeDescription: String = "" {
        didSet {
            typeDescriptionLabel.text = "\(typeDescription)"
        }
    }
    
    // MARK: - Initializers
    
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
        addSubviews([typeLabel, typeDescriptionLabel])
        
        typeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(26)
        }
        
        typeDescriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(typeLabel.snp.bottom).offset(11)
        }
    }
}
