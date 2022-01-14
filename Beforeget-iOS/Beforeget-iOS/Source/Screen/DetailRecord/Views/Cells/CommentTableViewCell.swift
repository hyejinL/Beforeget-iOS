//
//  CommentTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class CommentTableViewCell: UITableViewCell, UITableViewRegisterable {

    // MARK: - Properties
    
    var cellMargin: CGFloat = 47
    
    public let titleLabel = CellTitleLabel().then {
        $0.title = "코멘트"
    }
    
    public var commentLabel = UILabel().then {
        $0.font = BDSFont.body4
        $0.textColor = Asset.Colors.black200.color
        $0.text = "꽤나 폭력적인 장면을 폭죽이 터진다거나, 슬로우 모션 등으로 표현하여 폭력성을 영상미로 승화시킨 점이 인상깊다. 또한 영화 전반적으로 풍기는 앤틱한 분위기가 내 취향을 저격해서 눈이 즐거웠던 영화다."
        $0.lineBreakStrategy = .hangulWordPriority
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
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
        commentLabel.addLetterSpacing()
        commentLabel.addLineSpacing(spacing: 25)
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 commentLabel,
                                 lineView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.top)
            make.leading.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(6+cellMargin)
            make.trailing.equalToSuperview().inset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
            make.width.equalTo(2)
        }
    }
    
    // MARK: - Custom Method
    
    public func setData() {
       /// 문제 : 나중에 데이터 전달
    }
}
