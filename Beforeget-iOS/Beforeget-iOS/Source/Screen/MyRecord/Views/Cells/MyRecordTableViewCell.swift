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
    
    // MARK: - Enum
    
    public enum Media: Int, CaseIterable {
        case movie, book, tv, music, webtoon, youtube
        
        fileprivate var iconImage: UIImage {
            switch self {
            case .movie: return Asset.Assets.icnWebtoon.image
            case .book: return Asset.Assets.icnWebtoon.image
            case .tv: return Asset.Assets.icnWebtoon.image
            case .music: return Asset.Assets.icnWebtoon.image
            case .webtoon: return Asset.Assets.icnWebtoon.image
            case .youtube: return Asset.Assets.icnWebtoon.image
            }
        }
    }
    
    // MARK: - Properties
    
    private let record = RecordMannager()
    
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
    
    private var yearLabel = UILabel().then {
        $0.text = "2022."
    }
    
    private var monthLabel = UILabel().then {
        $0.text = "01."
    }
    
    private var dayLabel = UILabel().then {
        $0.text = "03."
    }
    
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
            make.bottom.equalToSuperview().inset(22)
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
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
    }
    
    // MARK: - Custom Method

    public func setData(index: Int) {
        onelineLabel.text = record.getData(index: index).oneline[0]
        titleLabel.text = record.getData(index: index).title
        starLabel.text = String(record.getStar(index: index))
        let category = record.getData(index: index).category
        
        switch category {
        case 1: return iconImageView.image = Asset.Assets.icnWebtoon.image
        case 2: return iconImageView.image = Asset.Assets.icnWebtoon.image
        case 3: return iconImageView.image = Asset.Assets.icnWebtoon.image
        case 4: return iconImageView.image = Asset.Assets.icnWebtoon.image
        case 5: return iconImageView.image = Asset.Assets.icnWebtoon.image
        default: return iconImageView.image = Asset.Assets.icnWebtoon.image
        }
    }
}
