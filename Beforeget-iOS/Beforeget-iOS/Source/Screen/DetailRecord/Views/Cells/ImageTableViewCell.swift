//
//  ImageTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class ImageTableViewCell: UITableViewCell, UITableViewRegisterable {

    // MARK: - Properties
    
    public let titleLabel = UILabel().then {
        $0.font = BDSFont.title5
        $0.textColor = Asset.Colors.black200.color
        $0.text = "코멘트"
    }
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Custom Method

}
