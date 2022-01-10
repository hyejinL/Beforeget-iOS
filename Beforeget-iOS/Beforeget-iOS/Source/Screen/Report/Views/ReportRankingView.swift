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
    private lazy var thirdankingView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private lazy var firstRankingCountLabel = UILabel().then {
        $0.textColor = .green
        $0.font = .systemFont(ofSize: 50, weight: .regular)
    }
    private lazy var secondRankingCountLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 50, weight: .regular)
    }
    private lazy var thirdRankingCountLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 50, weight: .regular)
    }
    
    private lazy var firstRankingTypeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    private lazy var secondRankingTypeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    private lazy var thirdRankingTypeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    private lazy var starImageView = UIImageView().then {
        $0.image = UIImage(named: " ")
        $0.contentMode = .scaleAspectFill
    }
    private lazy var bestRecordLabel = UILabel().then {
        $0.text = "the best record"
        $0.textColor = .green
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    var firstCount: Int = 0 {
        didSet { firstRankingCountLabel.text = "\(firstCount)" }
    }
    
    var secondCount: Int = 0 {
        didSet { secondRankingCountLabel.text = "\(secondCount)" }
    }
    
    var thirdCount: Int = 0 {
        didSet { secondRankingCountLabel.text = "\(thirdCount)" }
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
    }
    
    private func setupLayout() {
        
    }
}
