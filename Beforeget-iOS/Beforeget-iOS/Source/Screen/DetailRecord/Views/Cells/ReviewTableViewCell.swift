//
//  ReviewTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class ReviewTableViewCell: UITableViewCell, UITableViewRegisterable {

    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    public let titleLabel = CellTitleLabel().then {
        $0.title = "한 줄 리뷰"
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
