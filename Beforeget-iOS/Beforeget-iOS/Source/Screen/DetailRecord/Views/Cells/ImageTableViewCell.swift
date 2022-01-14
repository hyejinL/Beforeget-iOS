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
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "이미지제목"
    }
    
    private let starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLittleStarBlack.image
    }
    
    private let leftLineView = UIView()
    private let rightLineView = UIView()
    private let bottomLineView = UIView()
    
    public var cellImageView = UIImageView().then {
        $0.backgroundColor = .lightGray
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
        contentView.backgroundColor = .orange
        [leftLineView, rightLineView, bottomLineView].forEach {
            $0.backgroundColor = Asset.Colors.black200.color
        }
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 leftLineView,
                                 starImageView,
                                 rightLineView,
                                 cellImageView,
                                 bottomLineView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        [leftLineView, rightLineView, bottomLineView].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(2)
            }
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        leftLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(starImageView.snp.leading).offset(-6)
        }

        rightLineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(27)
            make.leading.equalTo(starImageView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(20)
        }

        /// 문제 : 이미지 가로길이가 295로 들어가고 높이는 항상 비율 계산해서 넣어줄 것
        cellImageView.snp.makeConstraints { make in
            make.top.equalTo(starImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(300)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
    
    // MARK: - Custom Method
    
    public func setData() {
       /// 문제 : 나중에 데이터 전달
    }
}
