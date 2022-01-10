//
//  FilterView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

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

class FilterView: UIView {

    // MARK: - Properties
    
    weak var dateDelegate: DateFilterDelegate?
    weak var mediaDelegate: MediaFilterDelegate?
    weak var starDelegate: StarFilterDelegate?
    
    private lazy var filterStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .horizontal
        $0.addArrangedSubviews([
            dateButton,
            mediaButton,
            starButton]
        )
    }
    
    private var dateButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchupDateButton),
                     for: .touchUpInside)
    }
    
    private var mediaButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchupMediaButton),
                     for: .touchUpInside)
    }
    
    private var starButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchupStarButton),
                     for: .touchUpInside)
    }
    
    private var dateLabel = UILabel().then {
        $0.text = "기간"
    }
    
    private var mediaLabel = UILabel().then {
        $0.text = "미디어"
    }
    
    private var starLabel = UILabel().then {
        $0.text = "별점"
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
        backgroundColor = .white
        
        [dateButton, mediaButton, starButton].forEach {
            $0.setImage(Asset.Assets.btnFilterInactive.image, for: .normal)
            $0.setImage(Asset.Assets.btnFilterActive.image, for: .highlighted)
        }
        
        [dateLabel, mediaLabel, starLabel].forEach {
            $0.textColor = Asset.Colors.black200.color
            $0.font = BDSFont.body1
        }
    }
    
    private func setupLayout() {
        addSubviews([filterStackView])
        dateButton.addSubview(dateLabel)
        mediaButton.addSubview(mediaLabel)
        starButton.addSubview(starLabel)
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
        }
        
        [dateLabel, mediaLabel, starLabel].forEach {
            $0.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
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
