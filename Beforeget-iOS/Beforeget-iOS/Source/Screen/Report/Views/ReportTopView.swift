//
//  ReportTopView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

class ReportTopView: UIView {

    // MARK: - Properties
    
    private var starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnStarBlack.image
        $0.contentMode = .scaleAspectFill
    }
    
    private var reportTitleLabel = UILabel().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.title4
    }
    
    private var reportDescriptionLabel = UILabel().then {
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
        backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        addSubviews([starImageView, reportTitleLabel, reportDescriptionLabel])
        
        starImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3)
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
}
