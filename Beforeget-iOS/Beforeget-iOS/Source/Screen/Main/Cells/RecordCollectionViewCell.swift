//
//  RecordCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/09.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecordCollectionViewCell"
    
    private let boxView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let countLabel = UILabel().then {
        $0.text = "6"
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody2
    }
    
    private let mediaLabel = UILabel().then {
        $0.text = "Movie"
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.body1
    }
    
    private lazy var mediaStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fill
        $0.addArrangedSubview(countLabel)
        $0.addArrangedSubview(mediaLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        contentView.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        [boxView, mediaStackView].forEach {
            contentView.addSubview($0)
        }
        
        boxView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(17)
            $0.width.height.equalTo(36)
        }
        
        mediaStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    func config(_ count: Int, _ media: String) {
        countLabel.text = "\(count)"
        mediaLabel.text = media
    }
}
