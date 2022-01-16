//
//  MainViewController.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/07.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {
    
    enum CollectionViewConst {
        static let cellInterval: CGFloat = 4
        static let cellIntervalCount: CGFloat = 5
        static let visibleCellsCount: CGFloat = 2.5
    }
    
    // MARK: - Properties
    
    private let topBarView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private let writingBackgroundView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.layer.cornerRadius = 15
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLogoMain.image
    }
    
    private let mediaImageView = UIImageView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    private let statisticsButton = UIButton().then {
        $0.setImage(Asset.Assets.btnStats.image, for: .normal)
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(Asset.Assets.btnSetting.image, for: .normal)
    }
    
    private let writingButton = UIButton().then {
        $0.setImage(Asset.Assets.btnWriting.image, for: .normal)
    }
    
    private let viewAllRecordsButton = UIButton().then {
        $0.setImage(Asset.Assets.btnAll.image, for: .normal)
    }
    
    private let messageLabel = UILabel().then {
        $0.text = "오늘은 어떤 미디어를\n감상하셨나요?"
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
        $0.font = BDSFont.title1
        $0.numberOfLines = 2
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body3
    }
    
    private lazy var recordTotalLabel = UILabel().then {
        $0.text = "\(recordTotal)"
        $0.textColor = Asset.Colors.gray200.color
        $0.font = BDSFont.title5
    }
    
    private lazy var topBarRightButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 3
        $0.addArrangedSubviews([statisticsButton, settingButton])
    }
    
    private lazy var descriptionStackView = UIStackView().then {
        let messageLabel = UILabel().then {
            $0.text = "님, 잊기 전에 기록해보세요."
            $0.textColor = Asset.Colors.black200.color
            $0.font = BDSFont.body4
        }
        
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.addArrangedSubviews([nameLabel, messageLabel])
    }
    
    private lazy var recordStackView = UIStackView().then {
        let recordLabel = UILabel().then {
            $0.text = "기록"
            $0.textColor = Asset.Colors.black200.color
            $0.font = BDSFont.title5
        }
        
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 7
        $0.addArrangedSubviews([recordLabel, recordTotalLabel])
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = CollectionViewConst.cellInterval
    }
    
    private lazy var recordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        
        RecordCollectionViewCell.register(target: $0)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private let dummyData: [Media] = [
        Media(book: 6, music: 6, movie: 6, tv: 6, youtube: 6, webtoon: 6)
    ]
    
    private lazy var recordTotal = MediaType.allCases.map { $0.recordCount(dummyData[0]) }
                                                     .reduce(0) { $0 + $1 }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        writingBackgroundView.makeShadow(Asset.Colors.black200.color, 0.2, CGSize(width: 0, height: 4), 21)
        writingBackgroundView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                           y: writingBackgroundView.bounds.maxY - writingBackgroundView.layer.shadowRadius,
                                                                           width: writingBackgroundView.bounds.width,
                                                                           height: writingBackgroundView.layer.shadowRadius)).cgPath
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([topBarView,
                          logoImageView,
                          topBarRightButtonStackView,
                          writingBackgroundView,
                          mediaImageView,
                          messageLabel,
                          descriptionStackView,
                          writingButton,
                          recordStackView,
                          viewAllRecordsButton,
                          recordCollectionView])
        
        topBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.top).inset(7)
            $0.leading.equalTo(topBarView.snp.leading).inset(20)
        }
        
        topBarRightButtonStackView.snp.makeConstraints {
            $0.top.equalTo(topBarView).inset(6)
            $0.trailing.equalTo(topBarView).inset(10)
        }
        
        writingBackgroundView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(397)
        }
        
        mediaImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(writingBackgroundView)
            $0.height.equalTo(145)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(mediaImageView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        writingButton.snp.makeConstraints {
            $0.top.equalTo(descriptionStackView.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
        }
        
        recordStackView.snp.makeConstraints {
            $0.top.equalTo(writingBackgroundView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(20)
        }
        
        viewAllRecordsButton.snp.makeConstraints {
            $0.centerY.equalTo(recordStackView)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        recordCollectionView.snp.makeConstraints {
            $0.top.equalTo(recordStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (recordCollectionView.frame.width - (CollectionViewConst.cellInterval * CollectionViewConst.cellIntervalCount)) / CollectionViewConst.visibleCellsCount,
                      height: recordCollectionView.frame.height)
    }
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MediaType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.className, for: indexPath) as? RecordCollectionViewCell
        else { return UICollectionViewCell() }
        
        let media: MediaType = MediaType(rawValue: indexPath.item) ?? .movie
        
        cell.config(media.recordCount(dummyData[0]), "\(media)")
        
        return cell
    }
}

