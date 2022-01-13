//
//  FilterButton.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

class FilterButton: UIButton {
    
    // MARK: - Properties
    
    public var text: String? = nil {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            layer.borderColor = Asset.Colors.black200.color.cgColor
            super.isSelected = newValue
        }
    }
    
    /// 나중에 지울 것
    private lazy var starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLittleStarBlack.image
    }
    
    // MARK: - Initializer
    
    public init(star: Bool) {
        super.init(frame: .zero)
        setupTitleColor()
        setupBorderColor()
        makeRound()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func setupTitleColor() {
        titleLabel?.font = BDSFont.body8
        if isSelected {
            setTitleColor(Asset.Colors.black200.color, for: .selected)
        } else {
            setTitleColor(Asset.Colors.gray300.color, for: .normal)
        }
    }
    
    private func setupBorderColor() {
        layer.borderColor = isSelected ?
        Asset.Colors.black200.color.cgColor :
        Asset.Colors.gray300.color.cgColor
        
        layer.borderWidth = 1
    }
}
