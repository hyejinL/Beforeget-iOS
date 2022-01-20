//
//  DetailRecordHeaderView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class DetailRecordHeaderView: UIView {
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared
    
    // MARK: - Properties
    
    public var postId = 0
    
    private var fontColorArray: [UIColor] = [
        Asset.Colors.white.color, Asset.Colors.black200.color,
        Asset.Colors.black200.color, Asset.Colors.white.color,
        Asset.Colors.black200.color, Asset.Colors.white.color,]
    
    private var colorArray: [UIColor] = [
        Asset.Colors.black200.color, Asset.Colors.gray400.color,
        Asset.Colors.gray300.color, Asset.Colors.black200.color,
        Asset.Colors.gray400.color, Asset.Colors.black200.color]
    
    public var reviewArray: [String] = [
        "흥미진진한 줄거리", "연기가 일품이에요!",
        "인생영화", "아름다운 영상미",
        "마음이 따뜻해져요", "개발자 인생!"]
    
    private let preferredLanguage = NSLocale.preferredLanguages[0]
    
    private let blackBackView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    public var iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    // MARK: - FIXME
    /// 문제 : 영어로 넘어오면 폰트 어떻게 해야 하나?
    public lazy var titleLabel = UILabel().then {
        $0.text = "0"
        $0.numberOfLines = 2
        $0.font = BDSFont.title3
        $0.textColor = Asset.Colors.white.color
        $0.textAlignment = .center
    }
    
    private let dateView = UIView().then {
        $0.makeRound(radius: 16)
        $0.layer.borderColor = Asset.Colors.white.color.cgColor
        $0.layer.borderWidth = 1
    }
    
    // MARK: - FIXME 날짜 변환
    public var dateLabel = UILabel().then {
        $0.text = "0"
        $0.font = BDSFont.enBody7
        $0.textColor = Asset.Colors.white.color
    }
    
    private let leftLineView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    public var starImageView = UIImageView().then {
        $0.image = Asset.Assets.btnStar1.image
    }
    
    private let rightLineView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private let reviewLabel = CellTitleLabel().then {
        $0.title = "한 줄 리뷰"
    }
    
    private let customFlowLayout = LeftAlignmentCollectionViewFlowLayout()
    
    public lazy var reveiwTagCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: customFlowLayout).then {
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            ReviewTagCollectionViewCell.register(target: $0)
        }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = Asset.Colors.white.color
        if preferredLanguage == "en" {
            titleLabel.font = BDSFont.enHead1
        } else if preferredLanguage == "kr" {
            titleLabel.font = BDSFont.title3
        }
    }
    
    private func setupLayout() {
        addSubviews([blackBackView,
                     leftLineView,
                     starImageView,
                     rightLineView,
                     reviewLabel,
                     reveiwTagCollectionView])
        dateView.addSubview(dateLabel)
        blackBackView.addSubviews([iconImageView, titleLabel, dateView])
        
        blackBackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(17)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        dateView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(32)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
        }
        
        leftLineView.snp.makeConstraints { make in
            make.top.equalTo(blackBackView.snp.bottom).offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalTo(starImageView.snp.leading).offset(-19)
            make.height.equalTo(2)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(blackBackView.snp.bottom).offset(32)
            make.width.equalTo(157)
            make.height.equalTo(38)
            make.centerX.equalToSuperview()
        }
        
        rightLineView.snp.makeConstraints { make in
            make.top.equalTo(blackBackView.snp.bottom).offset(50)
            make.trailing.equalToSuperview()
            make.leading.equalTo(starImageView.snp.trailing).offset(19)
            make.height.equalTo(2)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(starImageView.snp.bottom).offset(48)
            make.leading.equalToSuperview().inset(20)
        }
        
        reveiwTagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(120)
            // MARK: FIXME - 한줄 리뷰 높이를 1~2 / 3~4 / 5~6 일 때 나눠서 계산해줘야 함
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension DetailRecordHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let reviewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewTagCollectionViewCell.className,
            for: indexPath) as? ReviewTagCollectionViewCell
        else { return UICollectionViewCell() }
        reviewCell.config(
            reviewArray[indexPath.item],
            color: colorArray[indexPath.item],
            fontColor: fontColorArray[indexPath.item])
        return reviewCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailRecordHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let reviewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewTagCollectionViewCell.className,
            for: indexPath) as? ReviewTagCollectionViewCell else { return .zero }
        
        reviewCell.reviewLabel.text = reviewArray[indexPath.item]
        reviewCell.reviewLabel.sizeToFit()
        let cellWidth = reviewCell.reviewLabel.frame.width + 32
        
        return CGSize(width: cellWidth, height: 30)
    }
}
