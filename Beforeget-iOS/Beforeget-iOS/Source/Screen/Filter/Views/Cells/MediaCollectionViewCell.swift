//
//  MediaCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class MediaCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
   
    private lazy var firstButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            movieButton, bookButton])
    }
        
    private lazy var secondButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            tvButton, musicButton])
    }
    
    private lazy var thirdButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            webtoonButton, youtubeButton])
    }
    
    private let movieButton = UIButton().then {
        $0.setImage(Asset.Assets.boxMovie.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveMovie.image, for: .normal)
    }
    
    private let bookButton = UIButton().then {
        $0.setImage(Asset.Assets.boxBook.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveBook.image, for: .normal)
    }
    
    private let tvButton = UIButton().then {
        $0.setImage(Asset.Assets.boxTV.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveTv.image, for: .normal)
    }
    
    private let musicButton = UIButton().then {
        $0.setImage(Asset.Assets.boxMusic.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveMusic.image, for: .normal)
    }
    
    private let webtoonButton = UIButton().then {
        $0.setImage(Asset.Assets.boxWebtoon.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveWebtoon.image, for: .normal)
    }
    
    private let youtubeButton = UIButton().then {
        $0.setImage(Asset.Assets.boxYoutube.image, for: .selected)
        $0.setImage(Asset.Assets.boxInactiveYoutube.image, for: .normal)
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
        
        [movieButton, bookButton,
         tvButton, musicButton,
         webtoonButton, youtubeButton].forEach {
            $0.addTarget(self, action: #selector(touchupMediaButton(_:)), for: .touchUpInside)
        }
    }
    
    private func setupLayout() {
        contentView.addSubviews([firstButtonStackView,
                                secondButtonStackView,
                                thirdButtonStackView])
        
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
        
        thirdButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(secondButtonStackView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(37)
        }
    }
    
    // MARK: - @objc

    @objc func touchupMediaButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
