//
//  FilterView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

/// 내 기록 모아보는 곳에서 필터 스택뷰가 있는 부분

// MARK: - Delegate

protocol DateFilterDelegate: MyRecordViewController {
    func clickDateButton()
}

protocol MediaFilterDelegate: MyRecordViewController {
    func clickMediaButton()
}

protocol StarFilterDelegate: MyRecordViewController {
    func clickStarButton()
}

public class FilterView: UIView {
    
    // MARK: - Properties
        
    public var dateString: String?
    
    weak var dateDelegate: DateFilterDelegate?
    weak var mediaDelegate: MediaFilterDelegate?
    weak var starDelegate: StarFilterDelegate?
    
    private lazy var filterStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.addArrangedSubviews([
            dateButton,
            mediaButton,
            starButton]
        )
    }
    
    public var dateButton = UIButton().then {
        $0.setTitle("기간", for: .normal)
        $0.addTarget(self, action: #selector(touchupDateButton),
                     for: .touchUpInside)
    }
    
    public var mediaButton = UIButton().then {
        $0.setTitle("미디어", for: .normal)
        $0.addTarget(self, action: #selector(touchupMediaButton),
                     for: .touchUpInside)
    }
    
    public var starButton = UIButton().then {
        $0.setTitle("별점", for: .normal)
        $0.addTarget(self, action: #selector(touchupStarButton),
                     for: .touchUpInside)
    }
    
    // MARK: - Initializers
    
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
        backgroundColor = Asset.Colors.white.color
        
        [dateButton, mediaButton, starButton].forEach {
            $0.titleLabel?.font = BDSFont.body1
            $0.contentMode = .scaleToFill
            $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
            $0.setBackgroundImage(Asset.Assets.btnFilterInactive.image, for: .normal)
            $0.setBackgroundImage(Asset.Assets.btnFilterActive.image, for: .highlighted)
            $0.setBackgroundImage(Asset.Assets.btnFilterActive.image, for: .selected)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        }
    }
    
    private func setupLayout() {
        addSubviews([filterStackView])
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupDateButton() {
        dateDelegate?.clickDateButton()
    }
    
    @objc func touchupMediaButton() {
        mediaDelegate?.clickMediaButton()
    }
    
    @objc func touchupStarButton() {
        starDelegate?.clickStarButton()
    }
}
