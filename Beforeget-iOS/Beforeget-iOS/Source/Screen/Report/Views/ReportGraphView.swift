//
//  ReportGraphView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/10.
//

import UIKit

protocol ReportGraphViewDelegate: AnyObject {
    func touchupThreeMonthButton()
    func touchupFiveMonthButton()
}

class ReportGraphView: UIView {
    
    // MARK: - Properties
    
    private var monthLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody6
    }
    
    private var threeMonthButton = UIButton().then {
        $0.setTitle("3M", for: .normal)
        $0.titleLabel?.font = BDSFont.enBody7
        $0.addTarget(self, action: #selector(touchupThreeMonthButton), for: .touchUpInside)
        $0.setTitleColor(Asset.Colors.white.color, for: .selected)
        $0.setTitleColor(Asset.Colors.gray100.color, for: .normal)
    }
    
    private var fiveMonthButton = UIButton().then {
        $0.setTitle("5M", for: .normal)
        $0.titleLabel?.font = BDSFont.enBody7
        $0.addTarget(self, action: #selector(touchupFiveMonthButton), for: .touchUpInside)
        $0.setTitleColor(Asset.Colors.white.color, for: .selected)
        $0.setTitleColor(Asset.Colors.gray100.color, for: .normal)
    }
    
    var month: String = "" {
        didSet {
            monthLabel.text = "\(month)"
        }
    }
    
    var threeMonthSelected: Bool = false {
        didSet {
            threeMonthButton.isSelected = threeMonthSelected
        }
    }
    
    var fiveMonthSelected: Bool = false {
        didSet {
            fiveMonthButton.isSelected = fiveMonthSelected
        }
    }
    
    weak var delegate: ReportGraphViewDelegate?
    
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
        backgroundColor = Asset.Colors.black200.color
    }
    
    private func setupLayout() {
        addSubviews([monthLabel, threeMonthButton, fiveMonthButton])
        
        monthLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(31)
        }
        
        threeMonthButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(69)
            $0.centerY.equalTo(monthLabel)
        }
        
        fiveMonthButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.centerY.equalTo(monthLabel)
        }
    }
    
    // MARK: - @objc
    
    @objc
    func touchupThreeMonthButton() {
        delegate?.touchupThreeMonthButton()
    }
    
    @objc
    func touchupFiveMonthButton() {
        delegate?.touchupFiveMonthButton()
    }
}
