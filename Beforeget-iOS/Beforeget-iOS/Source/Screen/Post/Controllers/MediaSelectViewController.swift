//
//  MediaSelectViewController.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/10.
//

import UIKit

import SnapKit
import Then

final class MediaSelectViewController: UIViewController {
    
    enum CollectionViewConst {
        static let interitemSpacing: CGFloat = 17
        static let lineSpacing: CGFloat = 16
        static let widthCellCount: CGFloat = 2
        static let heightCellCount: CGFloat = 3
        static let cellLineSpacingCount: CGFloat = 2
    }
    
    // MARK: - Properties
    
    private let topBarView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private lazy var closeButton = CloseButton(root: self)
    
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(Asset.Colors.white.color, for: .normal)
        $0.backgroundColor = Asset.Colors.gray300.color
        $0.layer.cornerRadius = 4
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(touchupNextButton), for: .touchUpInside)
    }
    
    private let messageLabel = UILabel().then {
        $0.text = "오늘은 어떤 미디어를\n감상하셨나요?"
        $0.font = BDSFont.title2
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = CollectionViewConst.interitemSpacing
        $0.minimumLineSpacing = CollectionViewConst.lineSpacing
    }
    
    private lazy var mediaCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.isScrollEnabled = false
        
        MediaSelectCollectionViewCell.register(target: $0)
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([topBarView,
                          closeButton,
                          messageLabel,
                          mediaCollectionView,
                          nextButton])
        
        topBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.top).inset(6)
            $0.trailing.equalTo(topBarView.snp.trailing).inset(7)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
        
        mediaCollectionView.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(54)
            $0.leading.trailing.equalToSuperview().inset(21)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(mediaCollectionView.snp.bottom).offset(61)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(54)
        }
    }
    
    // MARK: - Custom Method
    
    private func activateNextButton() {
        nextButton.isEnabled = true
        nextButton.backgroundColor = Asset.Colors.black200.color
    }
    
    //MARK: - @objc
    
    @objc func touchupNextButton() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MediaSelectViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (mediaCollectionView.frame.width - CollectionViewConst.interitemSpacing) / CollectionViewConst.widthCellCount,
                      height: (mediaCollectionView.frame.height - CollectionViewConst.lineSpacing * CollectionViewConst.cellLineSpacingCount) / CollectionViewConst.heightCellCount)
    }
}

//MARK: - UICollectionViewDataSource

extension MediaSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MediaType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaSelectCollectionViewCell.className, for: indexPath) as? MediaSelectCollectionViewCell
        else { return UICollectionViewCell() }
        
        let media: MediaType = MediaType(rawValue: indexPath.item) ?? .movie
        
        cell.config("\(media)")
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MediaSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activateNextButton()
    }
}
