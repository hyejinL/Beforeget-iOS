//
//  MainViewController.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/07.
//

import UIKit

import Gifu

import SnapKit
import Then

final class MainViewController: UIViewController {
    
    // MARK: - Enum
    
    enum CollectionViewConst {
        static let cellInterval: CGFloat = 4
        static let cellIntervalCount: CGFloat = 5
        static let visibleCellsCount: CGFloat = UIScreen.main.hasNotch ? 2.5 : 2.6
    }
    
    // MARK: - Network
    
    private let mainAPI = MainAPI.shared
    private let myRecordAPI = MyRecordAPI.shared
    
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
    
    private let mediaImageView = GIFImageView().then {
        $0.animate(withGIFNamed: "mediaImageView")
    }
    
    private let reportButton = UIButton().then {
        $0.setImage(Asset.Assets.btnStats.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupReportButton(_:)), for: .touchUpInside)
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(Asset.Assets.btnSetting.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupSettingButton(_:)), for: .touchUpInside)
    }
    
    private let postButton = UIButton().then {
        $0.setImage(Asset.Assets.btnWriting.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupPostButton(_:)), for: .touchUpInside)
    }
    
    private let viewAllRecordsButton = UIButton().then {
        $0.setImage(Asset.Assets.btnAll.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupViewAllRecordButton(_:)), for: .touchUpInside)
    }
    
    private let messageLabel = UILabel().then {
        $0.text = "오늘은 어떤 미디어를\n감상하셨나요?"
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
        $0.font = BDSFont.title1
        $0.numberOfLines = 2
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "밴토리"
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
        $0.addArrangedSubviews([reportButton, settingButton])
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
    
    private var mainMediaData: Main?
    
    private lazy var recordTotal = MediaType.allCases.map { $0.recordCount(mainMediaData) }
        .reduce(0) { $0 + $1 }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()

        mainAPI.getMain { [weak self] data, err in
            guard let data = data else { return }
            self?.mainMediaData = data
            self?.recordTotalLabel.text = "\(data.movie + data.book + data.music + data.tv + data.youtube + data.webtoon)"
            self?.recordCollectionView.reloadData()
        }
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
        view.backgroundColor = Asset.Colors.white.color
        
        messageLabel.addLineSpacing(spacing: 34)
        messageLabel.textAlignment = .center
        
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
                          postButton,
                          recordStackView,
                          viewAllRecordsButton,
                          recordCollectionView])
        
        topBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(UIScreen.main.hasNotch ? 50 : 49)
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
            $0.height.equalTo(UIScreen.main.hasNotch ? 390 : 357)
        }
        
        mediaImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(writingBackgroundView)
            $0.height.equalTo(UIScreen.main.hasNotch ? 145 : 118)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(mediaImageView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        postButton.snp.makeConstraints {
            $0.top.equalTo(descriptionStackView.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
        }
        
        recordStackView.snp.makeConstraints {
            $0.top.equalTo(writingBackgroundView.snp.bottom).offset(UIScreen.main.hasNotch ? 28 : 19)
            $0.leading.equalToSuperview().inset(20)
        }
        
        viewAllRecordsButton.snp.makeConstraints {
            $0.centerY.equalTo(recordStackView)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        recordCollectionView.snp.makeConstraints {
            $0.top.equalTo(recordStackView.snp.bottom).offset(UIScreen.main.hasNotch ? 16 : 11)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupReportButton(_ sender: UIButton) {
        let reportViewController = ReportViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        navigationController?.pushViewController(reportViewController, animated: true)
    }
    
    @objc func touchupSettingButton(_ sender: UIButton) {
        let settingViewController = SettingViewController()
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc func touchupPostButton(_ sender: UIButton) {
        let mediaSelectViewController = UINavigationController(rootViewController: MediaSelectViewController())
        mediaSelectViewController.modalPresentationStyle = .overFullScreen
        present(mediaSelectViewController, animated: true, completion: nil)
    }
    
    @objc func touchupViewAllRecordButton(_ sender: UIButton) {
        let myRecordViewController = MyRecordViewController()
        navigationController?.pushViewController(myRecordViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recordViewController = MyRecordViewController()
        recordViewController.mediaID = indexPath.item+1
        navigationController?.pushViewController(recordViewController, animated: true)
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
        cell.config(media.recordCount(mainMediaData), "\(media)")
        return cell
    }
}
