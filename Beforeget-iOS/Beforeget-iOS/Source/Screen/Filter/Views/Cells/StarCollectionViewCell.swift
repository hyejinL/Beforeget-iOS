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
    func selectStarFilter(indexList: [Int])
}

class StarCollectionViewCell: UICollectionViewCell,
                              UICollectionViewRegisterable,
                              ResetFilterDelegate {
    
    // MARK: - Properties
        
    /// FilterView에 전달할 선택된 별점 필터 배열입니다.
    public var selectedStarArray: [Int] = []
        
    private var buttonTitle: [String] = []
    public lazy var starButtonList: [UIButton] = []
    
    weak var starFilterButtonDelegate: StarFilterButtonDelegate?
    
    private lazy var firstButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            starButtonList[0], starButtonList[1]])
    }
    
    private lazy var secondButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([
            starButtonList[2], starButtonList[3]])
    }
    
    private lazy var thirdButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 11
        $0.distribution = .fillEqually
        $0.addArrangedSubview(starButtonList[4])
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
        
        starButtonList.forEach {
            $0.contentMode = .scaleAspectFit
            $0.addTarget(self, action: #selector(touchupStarButton(_:)), for: .touchUpInside)
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
            make.leading.equalToSuperview().inset(21)
            make.trailing.equalTo(starButtonList[0].snp.trailing)
            make.height.equalTo(37)
        }
    }
    
    // MARK: - Custom Method
    
    func clickResetButton() {
        starButtonList.forEach {
            $0.isSelected = false
        }
    }
    
    private func setupButtonList() {
        buttonTitle.append(contentsOf: [
            "1", "2", "3", "4", "5"]
        )
        
        buttonTitle.forEach {
            let starButton = UIButton()
            var config = UIButton.Configuration.borderedTinted()
            config.imagePlacement = .leading
            config.imagePadding = 4
            config.title = $0
            config.attributedTitle?.font = BDSFont.body8
            config.image = Asset.Assets.icnLittleStarInactive.image
            config.baseBackgroundColor = .clear
            config.background.strokeWidth = 1
            config.background.cornerRadius = 4

            starButton.configurationUpdateHandler = { button in
                var config = button.configuration
                config?.image = button.isSelected ?
                Asset.Assets.icnLittleStarBlack.image :
                Asset.Assets.icnLittleStarInactive.image
                
                config?.background.strokeColor = button.isSelected ?
                Asset.Colors.black200.color :
                Asset.Colors.gray300.color
                
                config?.attributedTitle?.foregroundColor = button.isSelected ?
                Asset.Colors.black200.color :
                Asset.Colors.gray300.color
                
                button.configuration = config
            }
            starButton.configuration = config
            starButtonList.append(starButton)
        }
    }
    
    private func setupAction() {
        starButtonList.forEach {
            $0.addTarget(self, action: #selector(touchupStarButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupStarButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        print("sender.isSelected = \(sender.isSelected)")
        let senderIndex = Int(sender.titleLabel?.text ?? "0") ?? 0
        if let index = selectedStarArray.firstIndex(of: senderIndex) {
            print("index가 있음")
            selectedStarArray.remove(at: index)
            print("selectedStar = \(selectedStarArray)")
        } else {
            selectedStarArray.append(senderIndex)
            print("selectedStar = \(selectedStarArray)")
        }
        starFilterButtonDelegate?.selectStarFilter(indexList: selectedStarArray)
    }
}
