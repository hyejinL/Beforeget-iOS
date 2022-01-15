//
//  MediaCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/13.
//

import UIKit

import SnapKit
import Then

// MARK: - Delegate

protocol MediaFilterButtonDelegate: FilterModalViewController {
    func selectMediaFilter(index: Int)
}

class MediaCollectionViewCell: UICollectionViewCell,
                               UICollectionViewRegisterable,
                               ResetFilterDelegate {
    
    // MARK: - Properties
    
    private var buttonTitle: [String] = []
    private var mediaButtonList: [UIButton] = []
    
    weak var mediaFilterButtonDelegate: MediaFilterButtonDelegate?
    
    private lazy var firstButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([mediaButtonList[0], mediaButtonList[1]])
    }
    
    private lazy var secondButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([mediaButtonList[2], mediaButtonList[3]])
    }
    
    private lazy var thirdButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([mediaButtonList[4], mediaButtonList[5]])
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupButtonList()
        setupLayout()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = Asset.Colors.white.color
        mediaButtonList.forEach {
            $0.layer.borderColor = isSelected ?
            Asset.Colors.black200.color.cgColor :
            Asset.Colors.gray300.color.cgColor
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
    
    // MARK: - Custom Method
    
    public func clickResetButton() {
        mediaButtonList.forEach {
            $0.isSelected = false
        }
    }
    
    private func setupButtonList() {
        buttonTitle.append(contentsOf: [
            "Movie", "Book", "TV",
            "Music", "Webtoon", "Youtube"])
        
        buttonTitle.forEach {
            let mediaButton = UIButton()
            mediaButton.setTitle($0, for: .normal)
            mediaButton.titleLabel?.font = BDSFont.body8
            mediaButton.setTitleColor(Asset.Colors.gray300.color, for: .normal)
            mediaButton.setTitleColor(Asset.Colors.black200.color, for: .selected)
            mediaButton.layer.borderColor = Asset.Colors.gray300.color.cgColor
            mediaButton.layer.borderWidth = 1
            mediaButton.makeRound(radius: 4)
            mediaButtonList.append(mediaButton)
        }
    }
    
    private func setupAction() {
        mediaButtonList.forEach {
            $0.addTarget(self, action: #selector(touchupMediaButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupMediaButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        mediaFilterButtonDelegate?.selectMediaFilter(index: sender.tag)
    }
}
