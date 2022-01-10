//
//  ReportRankingView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/10.
//

import UIKit

final class ReportRankingView: UIView {

    // MARK: - Properties
    
    private lazy var firstRankingView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    private lazy var secondRankingView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    private lazy var thirdRankingView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private lazy var firstRankingCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.green100.color
        $0.font = BDSFont.enBody1
    }
    private lazy var secondRankingCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody3
    }
    private lazy var thirdRankingCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody3
    }
    
    private lazy var firstRankingTypeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = BDSFont.enBody5
    }
    private lazy var secondRankingTypeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = BDSFont.enBody5
    }
    private lazy var thirdRankingTypeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = BDSFont.enBody5
    }
    
    private lazy var starImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_star_green")
        $0.contentMode = .scaleAspectFill
    }
    private lazy var bestRecordLabel = UILabel().then {
        $0.text = "the best\nrecord"
        $0.textColor = Asset.Colors.green100.color
        $0.font = BDSFont.enBody6
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    var firstCount: Int = 0 {
        didSet { firstRankingCountLabel.text = "\(firstCount)" }
    }
    
    var secondCount: Int = 0 {
        didSet { secondRankingCountLabel.text = "\(secondCount)" }
    }
    
    var thirdCount: Int = 0 {
        didSet { thirdRankingCountLabel.text = "\(thirdCount)" }
    }
    
    var firstType: String = "" {
        didSet { firstRankingTypeLabel.text = firstType }
    }
    
    var secondType: String = "" {
        didSet { secondRankingTypeLabel.text = secondType }
    }
    
    var thirdType: String = "" {
        didSet { thirdRankingTypeLabel.text = thirdType }
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
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubviews([secondRankingView, firstRankingView, thirdRankingView])
        firstRankingView.addSubviews([firstRankingCountLabel, firstRankingTypeLabel, starImageView, bestRecordLabel])
        secondRankingView.addSubviews([secondRankingCountLabel, secondRankingTypeLabel])
        thirdRankingView.addSubviews([thirdRankingCountLabel, thirdRankingTypeLabel])
        
        secondRankingView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.equalTo(256)
            $0.width.equalTo(100)
        }
        
        secondRankingCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
        
        secondRankingTypeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(secondRankingCountLabel.snp.bottom).offset(13)
        }
        
        firstRankingView.snp.makeConstraints {
            $0.leading.equalTo(secondRankingView.snp.trailing).offset(2)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(131)
        }
        
        firstRankingCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
        
        firstRankingTypeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(firstRankingCountLabel.snp.bottom).offset(13)
        }
        
        starImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(firstRankingTypeLabel.snp.bottom).offset(86)
            $0.width.height.equalTo(18)
        }
        
        bestRecordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(starImageView.snp.bottom).offset(13)
        }
        
        thirdRankingView.snp.makeConstraints {
            $0.leading.equalTo(firstRankingView.snp.trailing).offset(2)
            $0.height.equalTo(230)
            $0.trailing.bottom.equalToSuperview()
        }
        
        thirdRankingCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
        }
        
        thirdRankingTypeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(thirdRankingCountLabel.snp.bottom).offset(13)
        }
    }
}
