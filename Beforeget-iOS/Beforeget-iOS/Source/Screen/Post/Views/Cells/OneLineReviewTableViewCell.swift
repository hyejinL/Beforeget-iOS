//
//  OneLineReviewTableViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class OneLineReviewTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private let onelineReviewLabel = UILabel().then {
        $0.text = "한 줄 리뷰"
        $0.font = BDSFont.body2
        $0.textColor = Asset.Colors.black200.color
    }
    
    private let starImage = UIImageView().then {
        $0.image = Asset.Assets.icnTextStar.image
    }
    
    private lazy var addButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "한 줄 리뷰 추가"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = BDSFont.body8
            outgoing.foregroundColor = Asset.Colors.black200.color
            return outgoing
        }
        config.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 22, bottom: 9, trailing: 22)
        
        $0.configuration = config
        $0.layer.cornerRadius = 18
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.black200.color.cgColor
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubviews([onelineReviewLabel,
                                 starImage,
                                 addButton])
        
        onelineReviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview()
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(onelineReviewLabel.snp.top)
            $0.leading.equalTo(onelineReviewLabel.snp.trailing).offset(2)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(onelineReviewLabel.snp.bottom).offset(17)
            $0.bottom.equalToSuperview().inset(31)
            $0.centerX.equalToSuperview()
        }
           
    }
}
