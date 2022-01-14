//
//  ReportSentenceCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class ReportSentenceCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    private var sentenceLabel = UILabel().then {
        $0.textColor = .white
        $0.font = BDSFont.body8
    }
    
    // MARK: - Life Cycle
    
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
        backgroundColor = Asset.Colors.black200.color
        
        layer.borderWidth = 1
        layer.borderColor = Asset.Colors.green100.color.cgColor
        makeRound(radius: 3)
    }
    
    private func setupLayout() {
        addSubview(sentenceLabel)
        
        sentenceLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    func initCell(sentence: String) {
        sentenceLabel.text = sentence
    }
}
