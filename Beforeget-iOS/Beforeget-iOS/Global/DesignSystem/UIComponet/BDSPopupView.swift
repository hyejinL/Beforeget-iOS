//
//  BDSPopupView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

import SnapKit
import Then

/// 두 줄 짜리 팝업뷰
///
// MARK: - Constant

public enum PopupText {
    static let back = "작성 중인 기록이 있어요!"
    static let subBack = "화면을 벗어나면 작성 중인 기록은 \n저장되지 않습니다."
    static let save = "기록을 저장할까요?"
    static let edit = "기록을 수정할까요?"
    static let delete = "정말로 삭제하시겠어요?"
    static let requiredField = "필수 항목을 입력해주세요."
}

public class BDSPopupView: UIView {

    // MARK: - Properties

    public var leftText: String? = nil {
        didSet { leftButton.setTitle(leftText, for: .normal) }
    }
    
    public var rightText: String? = nil {
        didSet { rightButton.setTitle(rightText, for: .normal) }
    }
    
    public var popupImage: UIImage? = nil {
        didSet {
            popupImageView.image = popupImage
        }
    }
    
    private lazy var popupImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var titleLabel = UILabel().then {
        $0.font = BDSFont.title7
    }
    
    private var infoLabel = UILabel().then {
        $0.font = BDSFont.body9
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray400.color
    }
    
    public var leftButton = UIButton().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.setTitleColor(Asset.Colors.gray200.color, for: .normal)
        $0.layer.maskedCorners = .layerMinXMaxYCorner
    }
    
    public var rightButton = UIButton().then {
        $0.backgroundColor = Asset.Colors.gray400.color
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.setTitleColor(Asset.Colors.gray200.color, for: .highlighted)
        $0.layer.maskedCorners = .layerMaxXMaxYCorner
    }
    
    // MARK: - Initializer
    
    public init(image: UIImage, title: String, info: String? = nil) {
        super.init(frame: .zero)
        popupImageView.image = image
        titleLabel.text = title
        infoLabel.text = info
        
        configUI()
        setupLayout(twoLine: (info != nil))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = Asset.Colors.white.color
        makeRound(radius: 10)
        [leftButton, rightButton].forEach {
            $0.titleLabel?.font = BDSFont.body2
            $0.clipsToBounds = true
            $0.makeRound(radius: 10)
        }
    }
    
    private func setupLayout(twoLine: Bool) {
        addSubviews([popupImageView,
                     titleLabel,
                     infoLabel,
                     lineView,
                     leftButton,
                     rightButton])
        
        snp.makeConstraints {
            $0.width.equalTo(290)
            $0.height.equalTo(220)
        }
        
        popupImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(twoLine ? 18 : 23)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(twoLine ? 87 : 105)
            make.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(169)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(50)
        }
        
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.equalTo(leftButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(50)
        }
        
        if twoLine {
            infoLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.centerX.equalToSuperview()
            }
        }
    }
}
