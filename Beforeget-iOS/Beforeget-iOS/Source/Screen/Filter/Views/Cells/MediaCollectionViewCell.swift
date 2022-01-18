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
    func selectMediaFilter(indexList: [String])
}

class MediaCollectionViewCell: UICollectionViewCell,
                               UICollectionViewRegisterable,
                               ResetFilterDelegate {
    
    // MARK: - Properties
        
    /// FilterView에 전달할 선택된 미디어 유형 필터 배열입니다.
    public var selectedMediaArray: [String] = []
    
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
        
        mediaButtonList.forEach {
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
            var config = UIButton.Configuration.borderedTinted()
            config.title = $0
            config.attributedTitle?.font = BDSFont.body8
            config.baseBackgroundColor = .clear
            config.background.strokeWidth = 1
            config.background.cornerRadius = 4

            mediaButton.configurationUpdateHandler = { button in
                var config = button.configuration
      
                config?.background.strokeColor = button.isSelected ?
                Asset.Colors.black200.color :
                Asset.Colors.gray300.color
                
                config?.attributedTitle?.foregroundColor = button.isSelected ?
                Asset.Colors.black200.color :
                Asset.Colors.gray300.color
                
                button.configuration = config
            }
            mediaButton.configuration = config
            mediaButtonList.append(mediaButton)
        }
    }
    
    public func setSelectedButton() {
        selectedMediaArray.forEach {
            let index = buttonTitle.firstIndex(of: $0) ?? 0
            mediaButtonList[index].isSelected = true
        }
    }
    
    private func setupAction() {
        mediaButtonList.forEach {
            $0.addTarget(self, action: #selector(touchupMediaButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupMediaButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        let senderIndex = sender.titleLabel?.text ?? "미디어"
        if let index = selectedMediaArray.firstIndex(of: senderIndex) {
            selectedMediaArray.remove(at: index)
            print("selectedMediaArray = \(selectedMediaArray)")
        } else {
            selectedMediaArray.append(senderIndex)
            print("selectedMediaArray = \(selectedMediaArray)")
        }
        mediaFilterButtonDelegate?.selectMediaFilter(indexList: selectedMediaArray)
    }
}
