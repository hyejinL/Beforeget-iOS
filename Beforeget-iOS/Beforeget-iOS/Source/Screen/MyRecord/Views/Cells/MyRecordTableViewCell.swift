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
    
    private let preferredLanguage = NSLocale.preferredLanguages[0]
    
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
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    public func configUI() {
        contentView.backgroundColor = Asset.Colors.black200.color
        
        [starLabel, yearLabel, monthLabel, dayLabel].forEach {
            $0.font = BDSFont.enBody7
            $0.textColor = Asset.Colors.white.color
        }
    }
    
    public func setupLayout() {
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
            make.height.equalTo(23)
        }
        
        onelineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(17)
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
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(19.7)
            make.height.equalTo(13)
        }
        
        if preferredLanguage == "en" {
            titleLabel.snp.updateConstraints { make in
                make.height.equalTo(28)
            }
        } else if preferredLanguage == "kr" {
            titleLabel.snp.updateConstraints { make in
                make.height.equalTo(23)
            }
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
        self.titleLabel.text = myRecord[index].title
        self.onelineLabel.text = myRecord[index].oneline
        let dateArray = myRecord[index].date.components(separatedBy: "-")
        self.yearLabel.text = "\(dateArray[0])."
        self.monthLabel.text = "\(dateArray[1])."
        self.dayLabel.text = "\(dateArray[2])"
        self.starLabel.text = String(myRecord[index].star)
        let categoryImage = myRecord[index].category
        
        switch categoryImage {
        case 1: return self.iconImageView.image = Asset.Assets.icnWriteMovie.image
        case 2: return self.iconImageView.image = Asset.Assets.icnWriteBook.image
        case 3: return self.iconImageView.image = Asset.Assets.icnWriteTv.image
        case 4: return self.iconImageView.image = Asset.Assets.icnWriteMusic.image
        case 5: return self.iconImageView.image = Asset.Assets.icnWriteWebtoon.image
        default: return self.iconImageView.image = Asset.Assets.icnWriteYoutube.image
        }
    }
}
