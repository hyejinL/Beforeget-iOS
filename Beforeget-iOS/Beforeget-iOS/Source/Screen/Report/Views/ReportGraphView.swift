//
//  ReportGraphView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/10.
//

import UIKit

// MARK: - Protocol

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
    
    private var maxCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody8
    }
    
    private var midCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody8
    }
    
    private var minCountLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody8
    }
    
    private var midLineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray100.color
    }
    
    private var minLineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray100.color
    }
    
    var barView1 = BarView()
    var barView2 = BarView()
    var barView3 = BarView()
    var barView4 = BarView()
    var barView5 = BarView().then {
        $0.setupTitleColor(Asset.Colors.green100.color)
        $0.setupProgressColor(Asset.Colors.green100.color)
    }
    
    private var barStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 22
    }
    
    var month: String = "" {
        didSet {
            monthLabel.text = "\(month)월"
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
    
    var maxCount: Int = 0 {
        didSet {
            maxCountLabel.text = "\(maxCount)"
        }
    }
    
    var midCount: Int = 0 {
        didSet {
            midCountLabel.text = "\(midCount)"
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
        addSubviews([monthLabel,
                     threeMonthButton,
                     fiveMonthButton,
                     maxCountLabel,
                     midCountLabel,
                     minCountLabel,
                     midLineView,
                     minLineView,
                     barStackView])
        
        barStackView.addArrangedSubviews([barView1, barView2, barView3, barView4, barView5])
        
        monthLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 31 : 21)
        }
        
        threeMonthButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(69)
            $0.centerY.equalTo(monthLabel)
        }
        
        fiveMonthButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.centerY.equalTo(monthLabel)
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 36 : 26)
            $0.leading.equalToSuperview().inset(25)
        }
        
        midCountLabel.snp.makeConstraints {
            $0.top.equalTo(maxCountLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 64 : 55)
            $0.leading.equalTo(maxCountLabel.snp.leading)
        }
        
        midLineView.snp.makeConstraints {
            $0.leading.equalTo(midCountLabel.snp.trailing).offset(7)
            $0.trailing.equalToSuperview().inset(45)
            $0.centerY.equalTo(midCountLabel.snp.centerY)
            $0.height.equalTo(0.5)
        }
        
        minCountLabel.snp.makeConstraints {
            $0.top.equalTo(midCountLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 65 : 55)
            $0.leading.equalTo(maxCountLabel.snp.leading)
        }
        
        minLineView.snp.makeConstraints {
            $0.leading.equalTo(minCountLabel.snp.trailing).offset(11)
            $0.trailing.equalToSuperview().inset(45)
            $0.centerY.equalTo(minCountLabel.snp.centerY)
            $0.height.equalTo(0.5)
        }
        
        [barView1, barView2, barView3, barView4, barView5].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(28)
                $0.height.equalTo(UIScreen.main.hasNotch ? 177 : 157)
            }
        }
        
        barStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 86 : 67)
            $0.bottom.equalToSuperview().inset(UIScreen.main.hasNotch ? 27 : 18)
        }
    }
    
    private func changeMonth(month: Int) {
        if month == 3 {
            [barView1, barView2, barView3, barView4, barView5].forEach {
                barStackView.removeArrangedSubview($0)
            }
            
            barStackView.addArrangedSubviews([barView3, barView4, barView5])
            barStackView.spacing = 42
        }
        
        if month == 5 {
            [barView1, barView2, barView3, barView4, barView5].forEach {
                barStackView.removeArrangedSubview($0)
            }
            
            barStackView.addArrangedSubviews([barView1, barView2, barView3, barView4, barView5])
            barStackView.spacing = 22
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupThreeMonthButton() {
        changeMonth(month: 3)
        delegate?.touchupThreeMonthButton()
    }
    
    @objc func touchupFiveMonthButton() {
        changeMonth(month: 5)
        delegate?.touchupFiveMonthButton()
    }
}

