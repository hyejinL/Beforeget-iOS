//
//  LineTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class LineTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "배우"
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    public var descriptionLabel = UILabel().then {
        $0.text = "콜린 퍼스, 태런 에저튼, 마크 스트롱, 마이클 케인, 사무엘 L. 잭슨"
        $0.font = BDSFont.body4
        $0.numberOfLines = 0
        $0.lineBreakStrategy = .hangulWordPriority
        $0.lineBreakMode = .byWordWrapping
    }
    
    // MARK: - Initializer

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
        
        descriptionLabel.addLetterSpacing()
        descriptionLabel.addLineSpacing(spacing: 25)
    }
    
    private func setupLayout() {
        contentView.addSubviews([lineView,
                                 titleLabel,
                                 descriptionLabel])
        
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(0.5)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(21)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(50)
            make.height.equalTo(23)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.leading).inset(62)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
    
    // MARK: - Custom Method
    
    public func config(_ title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
