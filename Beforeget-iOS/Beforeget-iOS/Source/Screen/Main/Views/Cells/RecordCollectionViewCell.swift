//
//  RecordCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/09.
//

import UIKit

import SnapKit
import Then

final class RecordCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    private let mediaImageView = UIImageView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody2
    }
    
    private let mediaLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.body1
    }
    
    private lazy var mediaStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.addArrangedSubviews([countLabel, mediaLabel])
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
        contentView.backgroundColor = Asset.Colors.black200.color
    }
    
    private func setupLayout() {
        contentView.addSubviews([mediaImageView, mediaStackView])
        
        mediaImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(17)
            $0.width.height.equalTo(36)
        }
        
        mediaStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Custom Method
    
    func config(_ count: Int, _ media: String) {
        countLabel.text = "\(count)"
        mediaLabel.text = media
    }
}
