//
//  LinkTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class LinkTableViewCell: UITableViewCell, UITableViewRegisterable {

    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "링크"
    }
    
    public var linkLabel = UILabel().then {
        $0.text = "https://www.youtube.com/watch?v=qZFo0PYkHFo"
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 linkLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(50)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
    
    // MARK: - Custom Method

}
