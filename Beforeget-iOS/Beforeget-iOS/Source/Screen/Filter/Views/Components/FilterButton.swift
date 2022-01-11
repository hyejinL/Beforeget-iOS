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
    
    public override var isSelected: Bool {
        didSet {
            isSelected = !isSelected
            setupBorderColor()
        }
    }
    
    public override var isHidden: Bool {
        didSet {
            starImageView.isHidden = true
        }
    }
    
    private lazy var starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLittleStarBlack.image
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        setTitleColor(Asset.Colors.gray300.color, for: .normal)
        setTitleColor(Asset.Colors.black200.color, for: .selected)
    }
    
    private func setupBorderColor() {
        layer.borderColor = isSelected ?
        Asset.Colors.black200.color.cgColor :
        Asset.Colors.gray300.color.cgColor
        
        layer.borderWidth = 1
    }
}
