//
//  ReportTopView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

protocol ReportTopViewDelegate {
    func touchUpMonthButton()
}

class ReportTopView: UIView {

    // MARK: - Properties
    
    var monthButton = RespondingButton().then {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월"
        
        $0.setTitle(dateFormatter.string(from: Date()), for: .normal)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.addTarget(self, action: #selector(touchUpMonthButton), for: .touchUpInside)
        $0.titleLabel?.font = BDSFont.enBody7
    }
    
    private lazy var starImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_star_black")
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.title4
        $0.addLetterSpacing()
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.text = "이번 달 나의 소비 유형을 알아보세요"
        $0.textColor = Asset.Colors.gray100.color
        $0.font = BDSFont.body2
        $0.addLetterSpacing()
    }
    
    var month: String = "" {
        didSet {
            titleLabel.text = "\(month)월의 땅콩님은?"
        }
    }
    
    var delegate: ReportTopViewDelegate?
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        configUI()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        
        monthButton.layer.borderWidth = 1
        monthButton.layer.borderColor = Asset.Colors.gray200.color.cgColor
        monthButton.layer.cornerRadius = 31 / 2
        monthButton.layer.masksToBounds = true
    }
    
    private func setupLayout() {
        addSubviews([monthButton, starImageView, titleLabel, descriptionLabel])
        
        monthButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
            $0.leading.trailing.equalToSuperview().inset(133)
            $0.height.equalTo(31)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(monthButton.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(20)
            $0.width.height.equalTo(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(starImageView)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
        }
    }
    
    // MARK: - @objc
    
    @objc
    func touchUpMonthButton() {
        delegate?.touchUpMonthButton()
    }
}
