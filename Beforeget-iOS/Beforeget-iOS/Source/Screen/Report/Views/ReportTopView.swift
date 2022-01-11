//
//  ReportTopView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

// MARK: - Protocol

protocol ReportTopViewDelegate: AnyObject {
    func touchupMonthButton()
}

class ReportTopView: UIView {

    // MARK: - Properties
    
    var monthButton = RespondingButton().then {
        $0.setTitle("2021년 12월", for: .normal)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.addTarget(self, action: #selector(touchupMonthButton), for: .touchUpInside)
        $0.titleLabel?.font = BDSFont.enBody7
    }
    
    private var starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnStarBlack.image
        $0.contentMode = .scaleAspectFill
    }
    
    private var reportTitleLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.title4
    }
    
    private var reportDescriptionLabel = UILabel().then {
        $0.text = "이번 달 나의 소비 유형을 알아보세요"
        $0.textColor = Asset.Colors.gray100.color
        $0.font = BDSFont.body6
    }
    
    var reportTitle: String = "" {
        didSet {
            reportTitleLabel.text = "\(reportTitle)"
        }
    }
    
    var reportDescription: String = "" {
        didSet {
            reportDescriptionLabel.text = "\(reportDescription)"
        }
    }
    
    weak var delegate: ReportTopViewDelegate?
    
    // MARK: - Initializer
    
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
        monthButton.makeRound(radius: 31 / 2)
    }
    
    private func setupLayout() {
        addSubviews([monthButton, starImageView, reportTitleLabel, reportDescriptionLabel])
        
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
        
        reportTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(starImageView)
        }
        
        reportDescriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(reportTitleLabel.snp.bottom).offset(7)
        }
    }
    
    // MARK: - @objc
    
    @objc
    func touchupMonthButton() {
        monthButton.becomeFirstResponder()
        delegate?.touchupMonthButton()
    }
}
