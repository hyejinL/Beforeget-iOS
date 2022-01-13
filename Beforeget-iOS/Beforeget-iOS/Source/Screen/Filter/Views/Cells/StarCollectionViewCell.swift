//
//  StarCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/13.
//

import UIKit

import SnapKit
import Then

// MARK: - Delegate

protocol StarFilterButtonDelegate: FilterModalViewController {
    func selectStarFilter(index: Int)
}

class StarCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    weak var starFilterButtonDelegate: StarFilterButtonDelegate?
    
    private lazy var firstButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            oneStarButton, twoStarButton])
    }
        
    private lazy var secondButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            threeStarButton, fourStarButton])
    }
    
    private let oneStarButton = UIButton().then {
        $0.tag = 1
        $0.setImage(Asset.Assets.boxActiveStar1.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveStar1.image, for: .normal)
    }
    
    private lazy var  twoStarButton = UIButton().then {
        $0.tag = 2
        $0.setImage(Asset.Assets.boxActiveStar2.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveStar2.image, for: .normal)
    }
    
    private lazy var  threeStarButton = UIButton().then {
        $0.tag = 3
        $0.setImage(Asset.Assets.boxActiveStar3.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveStar3.image, for: .normal)
    }
    
    private lazy var  fourStarButton = UIButton().then {
        $0.tag = 4
        $0.setImage(Asset.Assets.boxActiveStar4.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveStar4.image, for: .normal)
    }
    
    private lazy var  fiveStarButton = UIButton().then {
        $0.tag = 5
        $0.setImage(Asset.Assets.boxActiveStar5.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveStar5.image, for: .normal)
    }
    
    // MARK: - Initializer
    
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
        contentView.backgroundColor = .white
        
        [oneStarButton, twoStarButton,
         threeStarButton, fourStarButton,
         fiveStarButton].forEach {
            $0.addTarget(self, action: #selector(touchupStarButton(_:)), for: .touchUpInside)
        }
    }
    
    private func setupLayout() {
        contentView.addSubviews([firstButtonStackView,
                                 secondButtonStackView,
                                 fiveStarButton])
        
        firstButtonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(19)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(37)
        }
        
        secondButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(firstButtonStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(37)
        }
        
        fiveStarButton.snp.makeConstraints { make in
            make.top.equalTo(secondButtonStackView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(21)
            make.height.equalTo(37)
        }
    }
    
    // MARK: - Custom Method

    @objc func touchupStarButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        starFilterButtonDelegate?.selectStarFilter(index: sender.tag)
    }
}
