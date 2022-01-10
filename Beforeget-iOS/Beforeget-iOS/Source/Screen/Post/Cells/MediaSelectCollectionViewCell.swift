//
//  MediaSelectCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/10.
//

import UIKit
import Then
import SnapKit

class MediaSelectCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "MediaSelectCollectionViewCell"
    
    private let mediaBackgroundView = UIView().then {
        $0.makeRound(radius: 5)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.gray300.color.cgColor
    }
    
    private let mediaImageView = UIImageView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    private let mediaLabel = UILabel().then {
        $0.font = BDSFont.body4
        $0.textColor = Asset.Colors.black200.color
    }
    
    // MARK: - InitUI
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([mediaBackgroundView,
                                 mediaImageView,
                                 mediaLabel])
        
        mediaBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mediaImageView.snp.makeConstraints {
            $0.top.equalTo(mediaBackgroundView.snp.top).inset(42)
            $0.centerX.equalTo(mediaBackgroundView)
            $0.width.height.equalTo(20)
        }
        
        mediaLabel.snp.makeConstraints {
            $0.top.equalTo(mediaImageView.snp.bottom).offset(9)
            $0.centerX.equalTo(mediaBackgroundView)
        }
    }
    
    // MARK: - Custom Method
    func config(_ mediaName: String) {
        mediaLabel.text = mediaName
    }
}
