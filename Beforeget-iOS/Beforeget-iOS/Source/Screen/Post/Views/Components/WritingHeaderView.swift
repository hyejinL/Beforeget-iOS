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
        config.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20)
        
        $0.configuration = config
        $0.makeRound(radius: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.black200.color.cgColor
    }
    
    private let star1Button = UIButton().then {
        $0.setImage(Asset.Assets.btnBigstarInactive.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupStar1), for: .touchUpInside)
    }
    
    private let star2Button = UIButton().then {
        $0.setImage(Asset.Assets.btnBigstarInactive.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupStar2), for: .touchUpInside)
    }
    
    private let star3Button = UIButton().then {
        $0.setImage(Asset.Assets.btnBigstarInactive.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupStar3), for: .touchUpInside)
    }
    
    private let star4Button = UIButton().then {
        $0.setImage(Asset.Assets.btnBigstarInactive.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupStar4), for: .touchUpInside)
    }
    
    private let star5Button = UIButton().then {
        $0.setImage(Asset.Assets.btnBigstarInactive.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupStar5), for: .touchUpInside)
    }
    
    private let starDescriptionLabel = UILabel().then {
        $0.text = "이 영화의 별점은 몇 점인가요?"
        $0.font = BDSFont.body9
        $0.textColor = Asset.Colors.gray300.color
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray400.color
    }
    
    // MARK: - Initializer
    
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
                     star1Button,
                     star2Button,
                     star3Button,
                     star4Button,
                     star5Button,
                     starDescriptionLabel,
                     lineView])
        
        dateButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        star1Button.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(41)
            $0.trailing.equalTo(star2Button.snp.leading)
        }
        
        star2Button.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(31)
            $0.trailing.equalTo(star3Button.snp.leading)
        }
        
        star3Button.snp.makeConstraints {
            $0.top.equalTo(star1Button.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        star4Button.snp.makeConstraints {
            $0.top.equalTo(star2Button.snp.top)
            $0.leading.equalTo(star3Button.snp.trailing)
        }
        
        star5Button.snp.makeConstraints {
            $0.top.equalTo(star1Button.snp.top)
            $0.leading.equalTo(star4Button.snp.trailing)
        }
        
        starDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(star3Button.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(starDescriptionLabel.snp.bottom).offset(33)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupStar1() {
        star1Button.setImage(Asset.Assets.bigstarActive.image, for: .normal)
        [star2Button, star3Button, star4Button, star5Button].forEach {
            $0.setImage(Asset.Assets.bigstarInactive.image, for: .normal)
        }
    }
    
    @objc func touchupStar2() {
        [star1Button, star2Button].forEach {
            $0.setImage(Asset.Assets.bigstarActive.image, for: .normal)
        }
        [star3Button, star4Button, star5Button].forEach {
            $0.setImage(Asset.Assets.bigstarInactive.image, for: .normal)
        }
    }
    
    @objc func touchupStar3() {
        [star1Button, star2Button, star3Button].forEach {
            $0.setImage(Asset.Assets.bigstarActive.image, for: .normal)
        }
        [star4Button, star5Button].forEach {
            $0.setImage(Asset.Assets.bigstarInactive.image, for: .normal)
        }
    }
    
    @objc func touchupStar4() {
        [star1Button, star2Button, star3Button, star4Button].forEach {
            $0.setImage(Asset.Assets.bigstarActive.image, for: .normal)
        }
        [star5Button].forEach {
            $0.setImage(Asset.Assets.bigstarInactive.image, for: .normal)
        }
    }
    
    @objc func touchupStar5() {
        [star1Button, star2Button, star3Button, star4Button, star5Button].forEach {
            $0.setImage(Asset.Assets.bigstarActive.image, for: .normal)
        }
    }
}
