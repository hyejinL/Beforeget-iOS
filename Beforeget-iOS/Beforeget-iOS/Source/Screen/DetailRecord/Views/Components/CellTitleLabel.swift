//
//  CellTitleLabel.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

class CellTitleLabel: UILabel {

    // MARK: - Properties
    
    public var title: String? {
        didSet {
            text = title
            configUI()
        }
    }
        
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        font = BDSFont.title5
        textColor = Asset.Colors.black200.color
        textAlignment = .left
        addLetterSpacing()
    }
}
