//
//  CommaTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class CommaTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "콤마제목"
    }
    
    private let firstCommaImageView = UIImageView().then {
        $0.image = Asset.Assets.icnupQuotes.image
    }
    
    private let secondCommaImageView = UIImageView().then {
        $0.image = Asset.Assets.icndownQuotes.image
    }
    
    private var quoteLabel = UILabel().then {
        $0.text = "사실 이것은 다 빈치가 살짝 장난을 친 것입니다."
        $0.font = BDSFont.body4
        $0.textColor = Asset.Colors.black200.color
        $0.numberOfLines = 0
        $0.textAlignment = .left
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
        
        quoteLabel.addLetterSpacing()
        quoteLabel.addLineSpacing(spacing: 25)
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 firstCommaImageView,
                                 quoteLabel,
                                 secondCommaImageView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        [firstCommaImageView, secondCommaImageView].forEach {
            $0.snp.makeConstraints { make in
                make.width.height.equalTo(15)
            }
        }
        
        firstCommaImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().inset(43)
            make.leading.equalTo(firstCommaImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
        
        secondCommaImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(quoteLabel.snp.trailing).offset(8)
        }
    }
    
    // MARK: - Custom Method
    
    public func setData() {
       /// 문제 : 나중에 데이터 전달
    }
}
