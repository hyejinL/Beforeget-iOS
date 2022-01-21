//
//  TextTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class TextTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared

    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "텍스트제목"
    }
    
    public var descriptionLabel = UILabel().then {
        $0.font = BDSFont.body4
        $0.text = "세상에서 가장 위험한 면접이 시작된다! 높은 IQ, 주니어 체조대회 2년 연속 우승! 그러나 학교 중퇴, 해병대 중도 하차.동네 패싸움에 직장은 가져본 적도 없이 별볼일 없는 루저로 낙인 찍혔던 ‘그’가 ‘젠틀맨 스파이’로 전격 스카우트 됐다!"
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
        contentView.addSubviews([titleLabel, descriptionLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(23)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
    
    // MARK: - Custom Method

    public func config(_ index: Int) {
        guard let additional = myRecordAPI.myDetailRecord?.data?[index].additional else { return }
        guard let description = additional[index].content else { return }
        
        titleLabel.text = additional[index].type
        descriptionLabel.text = description
    }
}
