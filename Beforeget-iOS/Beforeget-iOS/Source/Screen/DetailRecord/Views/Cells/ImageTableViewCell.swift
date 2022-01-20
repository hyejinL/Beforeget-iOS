//
//  ImageTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import Kingfisher
import SnapKit
import Then

class ImageTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared
    
    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    private var imageHeight: CGFloat = 0
    
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
        $0.image = Asset.Assets.btnDownload.image
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
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
        
        [leftLineView, rightLineView, bottomLineView].forEach {
            $0.backgroundColor = Asset.Colors.black200.color
        }
        
        /// 문제 :  이미지
        guard let image = cellImageView.image?.resize(newWidth: 295) else { return }
        imageHeight = image.size.height
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

        cellImageView.snp.makeConstraints { make in
            make.top.equalTo(starImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(imageHeight)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
    
    // MARK: - Custom Method
    
    public func config(_ index: Int) {
        guard let additional = myRecordAPI.myDetailRecord?.data?[index].additional else { return }
        guard let imgUrl = additional[index].imgUrl1 else { return }
        
        titleLabel.text = additional[index].type
        cellImageView.kf.setImage(with: URL(string: imgUrl))
    }
}
