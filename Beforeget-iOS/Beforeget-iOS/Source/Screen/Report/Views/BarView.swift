//
//  BarView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/12.
//

import UIKit

import SnapKit
import Then

protocol BarViewDelegate: AnyObject {
    func touchupBar()
}

class BarView: UIView {
    
    // MARK: - Properties
    
    private var barBackgroundView = UIView().then {
        $0.backgroundColor = Asset.Colors.black100.color
    }
    
    private var barProgressView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private var barTitleLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody7
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    var barTitle: String = "" {
        didSet {
            barTitleLabel.text = barTitle
        }
    }
    
    var isEnter: Bool = false
    
    weak var delegate: BarViewDelegate?
    
    // MARK: - Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBar()
        setupTapGesture()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBar()
        setupTapGesture()
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    
    // MARK: - InitUI
    
    func initBar() {
        addSubviews([barTitleLabel, barBackgroundView, barProgressView, barTitleLabel])
        
        barTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        barBackgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(4)
            $0.height.equalTo(UIScreen.main.hasNotch ? 150 : 130)
            $0.top.equalToSuperview()
        }
        
        barProgressView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(4)
            $0.height.equalTo(0)
            $0.bottom.equalTo(barBackgroundView.snp.bottom)
        }
    }
    
    // MARK: - Custom Method
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupBar))
        barProgressView.addGestureRecognizer(tapGesture)
    }
    
    func animate(height: CGFloat) {
        barProgressView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        self.layoutIfNeeded()
        
        UIView.animate(withDuration: 1) {
            self.barProgressView.snp.updateConstraints {
                $0.height.equalTo(height)
            }
            self.layoutIfNeeded()
        }
    }
    
    func setupBarHeight(height: CGFloat) {
        barProgressView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        self.layoutIfNeeded()
    }
    
    func setupBackColor(_ color: UIColor) {
        barBackgroundView.backgroundColor = color
    }
    
    func setupProgressColor(_ color: UIColor) {
        barProgressView.backgroundColor = color
    }
    
    func setupTitleColor(_ color: UIColor) {
        barTitleLabel.textColor = color
    }
    
    // MARK: - @objc
    
    @objc func touchupBar() {
        delegate?.touchupBar()
    }
}
