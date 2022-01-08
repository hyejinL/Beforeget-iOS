//
//  Temp.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then

final class BDSButton: UIButton {
    
    // MARK: - Properties

    public var text: String? = nil {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    public var isDisabled: Bool = false {
        didSet {
            self.isEnabled = !isDisabled
            setBackgroundColor()
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor()
        setBackgroundColor()
        makeRound()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func setTitleColor() {
        titleLabel?.font = BDSFont.title6
        setTitleColor(Asset.Colors.white.color, for: .normal)
        setTitleColor(Asset.Colors.gray100.color, for: .highlighted)
    }
    
    private func setBackgroundColor() {
        backgroundColor = isDisabled ?
        Asset.Colors.gray300.color :
        Asset.Colors.black200.color
    }
}
