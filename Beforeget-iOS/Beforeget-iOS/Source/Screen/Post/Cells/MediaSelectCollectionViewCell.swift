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
    
    private lazy var mediaStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 9
        $0.addSubviews([mediaImageView, mediaLabel])
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
        mediaBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mediaStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    func config() {
        
    }
}
