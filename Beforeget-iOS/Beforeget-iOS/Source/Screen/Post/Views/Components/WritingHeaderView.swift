//
//  WritingHeaderView.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

final class WritingHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "WritingHeaderView"
    // MARK: - Properties
    
    private let dateButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "2022. 01. 08. SAT"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = BDSFont.enBody7
            outgoing.foregroundColor = Asset.Colors.black200.color
            return outgoing
        }
        config.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 18, bottom: 9, trailing: 18)
        
        $0.configuration = config
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.black200.color.cgColor
    }
    
    private let star1 = UIButton().then {
        $0.setImage(Asset.Assets.btnStarInactive.image, for: .normal)
    }
    
    private let star2 = UIButton().then {
        $0.setImage(Asset.Assets.btnStarInactive.image, for: .normal)
    }
    
    private let star3 = UIButton().then {
        $0.setImage(Asset.Assets.btnStarInactive.image, for: .normal)
    }
    
    private let star4 = UIButton().then {
        $0.setImage(Asset.Assets.btnStarInactive.image, for: .normal)
    }
    
    private let star5 = UIButton().then {
        $0.setImage(Asset.Assets.btnStarInactive.image, for: .normal)
    }
    
    private let starDescriptionLabel = UILabel().then {
        $0.text = "이 영화의 별점은 몇 점인가요?"
        $0.font = BDSFont.body9
        $0.textColor = Asset.Colors.gray300.color
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray400.color
    }
    
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
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
        contentView.addSubviews([dateButton,
                     star1,
                     star2,
                     star3,
                     star4,
                     star5,
                     starDescriptionLabel,
                     lineView])
        
        dateButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        star1.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(41)
            $0.trailing.equalTo(star2.snp.leading)
        }
        
        star2.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(31)
            $0.trailing.equalTo(star3.snp.leading)
        }
        
        star3.snp.makeConstraints {
            $0.top.equalTo(star1.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        star4.snp.makeConstraints {
            $0.top.equalTo(star2.snp.top)
            $0.leading.equalTo(star3.snp.trailing)
        }
        
        star5.snp.makeConstraints {
            $0.top.equalTo(star1.snp.top)
            $0.leading.equalTo(star4.snp.trailing)
        }
        
        starDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(star3.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(starDescriptionLabel.snp.bottom).offset(33)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Custom Method
    
}
