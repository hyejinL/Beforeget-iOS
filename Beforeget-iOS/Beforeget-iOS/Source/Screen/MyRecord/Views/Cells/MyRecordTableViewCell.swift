//
//  MyRecordTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/10.
//

import UIKit

import SnapKit
import Then

class MyRecordTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared
    
    // MARK: - Properties
    
    private var emptyStateImageView = UIImageView().then {
        $0.image = Asset.Assets.icnRecordEmpty.image
    }
    
    private var iconImageView = UIImageView()
    
    private var titleLabel = UILabel().then {
        $0.font = BDSFont.title4
        $0.textColor = Asset.Colors.white.color
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private var onelineLabel = UILabel().then {
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.white.color
    }
    
    private var starImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLittleStarWhite.image
    }
    
    private var starLabel = UILabel().then {
        $0.text = "3"
    }
    
    private lazy var dateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.addArrangedSubviews(
            [yearLabel, monthLabel, dayLabel])
    }
    
    private var yearLabel = UILabel()
    private var monthLabel = UILabel()
    private var dayLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let myRecord = myRecordAPI.myRecord?.data
        guard let myRecord = myRecord else { return }
        
        if myRecord.isEmpty {
            setupEmptyLayout()
        } else {
            configUI()
            setupLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI

    private func setupEmptyLayout() {
        contentView.addSubview(emptyStateImageView)
        
        emptyStateImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(189)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
            make.height.equalTo(114)
        }
    }
    
    private func configUI() {
        contentView.backgroundColor = Asset.Colors.black200.color
        
        [starLabel, yearLabel, monthLabel, dayLabel].forEach {
            $0.font = BDSFont.enBody7
            $0.textColor = Asset.Colors.white.color
        }
    }
    
    private func setupLayout() {
        contentView.addSubviews([
            iconImageView,
            titleLabel,
            onelineLabel,
            starLabel,
            starImageView,
            dateStackView])
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(19)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(150)
        }
        
        onelineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        starLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.trailing.equalToSuperview().inset(20)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
            make.trailing.equalTo(starLabel.snp.leading).offset(-4)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(19.7)
            make.height.equalTo(13)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: 0, left: 0, bottom: 6, right: 0))
    }
    
    // MARK: - Custom Method

    public func config(index: Int) {
        
        let myRecord = myRecordAPI.myRecord?.data
        guard let myRecord = myRecord else { return }
        
        if myRecord.isEmpty {
            print("비어있다")
            
        } else {
            print(index, "이게모야???")
            titleLabel.text = myRecord[index].title
            onelineLabel.text = myRecord[index].oneline
            let dateArray = myRecord[index].date.components(separatedBy: "-")
            yearLabel.text = "\(dateArray[0])."
            monthLabel.text = "\(dateArray[1])."
            dayLabel.text = "\(dateArray[2])"
            starLabel.text = String(myRecord[index].star)
            let categoryImage = myRecord[index].category
            
            // MARK: - FIXME 에셋 넘겨주면 이미지 바꾸기
            switch categoryImage {
            case 0: return iconImageView.image = Asset.Assets.icnWriteMovie.image
            case 1: return iconImageView.image = Asset.Assets.icnWriteBook.image
            case 2: return iconImageView.image = Asset.Assets.icnWriteTv.image
            case 3: return iconImageView.image = Asset.Assets.icnWriteMusic.image
            case 4: return iconImageView.image = Asset.Assets.icnWriteWebtoon.image
            default: return iconImageView.image = Asset.Assets.icnWriteYoutube.image
            }
        }
    }
}
