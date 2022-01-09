//
//  ViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit
import Then
import SnapKit
import CoreMedia

final class MainViewController: UIViewController {
    
    enum MediaType: Int, CustomStringConvertible {
        case movie
        case book
        case tv
        case music
        case webtoon
        case youtube
        
        var description: String {
            switch self {
            case .movie: return "Movie"
            case .book: return "Book"
            case .tv: return "TV"
            case .music: return "Music"
            case .webtoon: return "Webtoon"
            case .youtube: return "Youtube"
            }
        }
        
        func count(_ media: Media) -> Int {
            switch self {
            case .movie: return media.movie
            case .book: return media.book
            case .tv: return media.tv
            case .music: return media.music
            case .webtoon: return media.webtoon
            case .youtube: return media.youtube
            }
        }
    }
    
    // MARK: - Properties
    
    private let topBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = Asset.Assets.icnLogoMain.image
    }
    
    private let statisticsButton = UIButton().then {
        $0.setImage(Asset.Assets.btnStats.image, for: .normal)
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(Asset.Assets.btnSetting.image, for: .normal)
    }
    
    private lazy var topBarRightButtonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 3
        $0.addArrangedSubviews([statisticsButton, settingButton])
    }
    
    private let writingView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.makeShadow(Asset.Colors.black200.color, 0.125, CGSize(width: 0, height: 4), 21)
    }
    
    // 이미지 나오면 고칠 것!!
    private let mediaImageView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }

    private let messageLabel = UILabel().then {
        $0.text = "오늘은 어떤 미디어를\n감상하셨나요?"
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
        $0.font = BDSFont.title1
        $0.numberOfLines = 2
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "은서"
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body3
    }
    
    private lazy var descriptionStackView = UIStackView().then {
        let label = UILabel().then {
            $0.text = "님, 잊기 전에 기록해보세요."
            $0.textColor = Asset.Colors.black200.color
            $0.font = BDSFont.body4
        }
        
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.addArrangedSubviews([nameLabel, label])
    }
    
    private let writingButton = UIButton().then {
        $0.setImage(Asset.Assets.btnWriting.image, for: .normal)
    }
    
    private let recordCountLabel = UILabel().then {
        $0.text = "30"
        $0.textColor = Asset.Colors.gray200.color
        $0.font = BDSFont.title5
    }
    
    private lazy var recordStackView = UIStackView().then {
        let label = UILabel().then {
            $0.text = "기록"
            $0.textColor = Asset.Colors.black200.color
            $0.font = BDSFont.title5
        }
        
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 7
        $0.addArrangedSubviews([label, recordCountLabel])
    }
    
    private let viewAllRecordsButton = UIButton().then {
        $0.setImage(Asset.Assets.btnAll.image, for: .normal)
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 4
    }
    
    private lazy var recordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
        
        $0.register(RecordCollectionViewCell.self, forCellWithReuseIdentifier: RecordCollectionViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
    }
    
    let dummyData: [Media] = [
        Media(book: 6, music: 6, movie: 6, tv: 6, youtube: 6, webtoon: 6)
    ]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = BDSFont.title1
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([topBarView,
                          logoImageView,
                          topBarRightButtonStackView,
                          writingView,
                          mediaImageView,
                          messageLabel,
                          descriptionStackView,
                          writingButton,
                          recordStackView,
                          viewAllRecordsButton,
                          recordCollectionView])
        
        topBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(64)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.top).inset(10)
            $0.leading.equalTo(topBarView.snp.leading).inset(20)
        }
        
        topBarRightButtonStackView.snp.makeConstraints {
            $0.top.trailing.equalTo(topBarView).inset(10)
        }
        
        writingView.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(363)
        }
        
        mediaImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(writingView)
            $0.height.equalTo(131)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(mediaImageView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        descriptionStackView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        writingButton.snp.makeConstraints {
            $0.top.equalTo(descriptionStackView.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
        }
        
        recordStackView.snp.makeConstraints {
            $0.top.equalTo(writingView.snp.bottom).offset(29)
            $0.leading.equalToSuperview().inset(20)
        }
        
        viewAllRecordsButton.snp.makeConstraints {
            $0.centerY.equalTo(recordStackView)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        recordCollectionView.snp.makeConstraints {
            $0.top.equalTo(recordStackView.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(11)
        }
    }
    
    // MARK: - Custom Method
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 146, height: recordCollectionView.frame.size.height)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordCollectionViewCell.identifier, for: indexPath) as? RecordCollectionViewCell
        else { return UICollectionViewCell() }
        
        let media: MediaType = MediaType(rawValue: indexPath.item) ?? .movie
        
        cell.config(media.count(dummyData[0]), "\(media)")
        
        return cell
    }
}

