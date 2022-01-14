//
//  SongListTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class SongListTableViewCell: UITableViewCell, UITableViewRegisterable {

    // MARK: - Properties
    
    private let backView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
        $0.makeRound(radius: 4)
    }
    
    private let songIconImageView = UIImageView().then {
//        $0.image = Asset.Assets.
        $0.backgroundColor = .white
    }
    
    public var songLabel = UILabel().then {
        $0.font = BDSFont.body4
        $0.textColor = Asset.Colors.white.color
        $0.numberOfLines = 0
        $0.text = "오아ㅏ아아아아아아앙"
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
        contentView.addSubviews([backView])
        backView.addSubviews([songIconImageView,
                              songLabel])
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        songIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.5)
            make.leading.equalToSuperview().inset(16)
            make.width.height.equalTo(20)
        }
        
        songLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalTo(songIconImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Custom Method
    
    public func setData(_ data: String) {
        songLabel.text = data
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
}
