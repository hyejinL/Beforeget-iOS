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
    func selectMediaFilter(index: [String])
}

class MediaCollectionViewCell: UICollectionViewCell,
                               UICollectionViewRegisterable,
                               ResetFilterDelegate {
    
    // MARK: - Properties
    
    var isMediaSelected: Bool = true
    
    /// FilterView에 전달할 선택된 미디어 유형 필터 배열입니다.
    private var selectedMedia: [String] = []
    
    public var buttonTitle: [String] = []
    public var mediaButtonList: [UIButton] = []
    
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
    
    func removeDuplication(in array: [String]) -> [String]{
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        return duplicationRemovedArray
    }
    
    // MARK: - @objc
    
    @objc func touchupMediaButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        sender.layer.borderColor = isMediaSelected ?
        Asset.Colors.black200.color.cgColor :
        Asset.Colors.gray300.color.cgColor
        
        if sender.isSelected {
            selectedMedia.append(sender.titleLabel?.text ?? "")
        }
        
        mediaFilterButtonDelegate?.selectMediaFilter(index: removeDuplication(in: selectedMedia))
    }
}
