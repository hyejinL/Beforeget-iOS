//
//  FilterView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

class FilterView: UIView {

    // MARK: - Properties
    
    private lazy var filterStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .horizontal
        $0.addArrangedSubviews([
            dateButton,
            mediaButton,
            starButton]
        )
    }
    
    private var dateButton = UIButton()
    private var mediaButton = UIButton()
    private var starButton = UIButton()
    
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
}
