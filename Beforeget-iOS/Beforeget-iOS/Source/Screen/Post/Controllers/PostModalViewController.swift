//
//  PostModalViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/17.
//

import UIKit

import SnapKit
import Then

final class PostModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private var modalBackView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private var indicatorView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
        $0.makeRound(radius: 2)
    }
    
    private var goodLabel = UILabel().then {
        $0.text = "좋았어요"
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.title6
    }
    
    private var badLabel = UILabel().then {
        $0.text = "아쉬워요"
        $0.textColor = Asset.Colors.gray300.color
        $0.font = BDSFont.title6
    }
    
    private var statusMovedView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray400.color
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
        $0.scrollDirection = .horizontal
    }
    
    private lazy var reviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        
        $0.delegate = self
        $0.dataSource = self
        
        PostModalGoodCollectionViewCell.register(target: $0)
        PostModalBadCollectionViewCell.register(target: $0)
    }
    
    private var countLabel = UILabel().then {
        $0.text = "0 / 6"
        $0.textColor = Asset.Colors.gray200.color
        $0.font = BDSFont.body3
    }
    
    private var resetButton = UIButton().then {
        $0.setImage(Asset.Assets.btnRefreshAll.image, for: .normal)
    }
    
    private var applyButton = BDSButton().then {
        $0.text = "적용"
        $0.isDisabled = true
    }
    
    private var currentIndex = 0
    private var count = 0
    
    // MARK: - TODO REMOVE
    private var goodReviews = ["아름다운 영상미", "연기가 훌륭해요", "흥미진진한 줄거리", "OST 맛집", "최고의 반전!", "마음이 따듯해져요", "좋아하는 배우", "인생"]
    private var badReviews = ["살짝 지루해요", "연기가 별로에요", "내용이 뻔해요", "괜히 봤어요", "결말이 아쉬워요", "개연성이 부족해요"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        setTextLabelGesture()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.black200.color.withAlphaComponent(0.5)
    }
    
    private func setupLayout() {
        view.addSubview(modalBackView)
        modalBackView.addSubviews([indicatorView,
                                   goodLabel,
                                   badLabel,
                                   lineView,
                                   statusMovedView,
                                   reviewCollectionView,
                                   countLabel,
                                   applyButton,
                                   resetButton])
        
        modalBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(379)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.trailing.equalToSuperview().inset(165)
            $0.height.equalTo(4)
        }
        
        goodLabel.snp.makeConstraints {
            $0.top.equalTo(indicatorView.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(73)
        }
        
        badLabel.snp.makeConstraints {
            $0.centerY.equalTo(goodLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(73)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(goodLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        statusMovedView.snp.makeConstraints {
            $0.centerY.equalTo(lineView.snp.centerY)
            $0.width.equalTo(74)
            $0.height.equalTo(2)
            $0.centerX.equalTo(goodLabel.snp.centerX)
        }
        
        reviewCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(reviewCollectionView.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(21)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(248)
            $0.height.equalTo(54)
        }
        
        resetButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.centerY.equalTo(applyButton.snp.centerY)
            $0.width.equalTo(76)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Custom Method
    
    private func setTextLabelGesture() {
        let tapGoodLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToGood))
        goodLabel.addGestureRecognizer(tapGoodLabelGesture)
        goodLabel.isUserInteractionEnabled = true
        
        let tapBadLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToBad))
        badLabel.addGestureRecognizer(tapBadLabelGesture)
        badLabel.isUserInteractionEnabled = true
    }
        
    // MARK: - @objc
    
    @objc
    private func dragToGood() {
        if currentIndex == 1 {
            let indexPath = IndexPath(item: 0, section: 0)
            reviewCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.goodLabel.textColor =  Asset.Colors.black200.color
            self.badLabel.textColor = Asset.Colors.gray200.color
        }
    }
    
    @objc
    private func dragToBad() {
        let indexPath = IndexPath(item: 1, section: 0)
        reviewCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if currentIndex == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = CGAffineTransform(translationX: (self.view.frame.width - 40) / 2 , y: 0)
            }
            currentIndex = 1
            self.goodLabel.textColor = Asset.Colors.gray200.color
            self.badLabel.textColor =  Asset.Colors.black200.color
        }
    }
}

// MARK: - UICollectionView Delegate

extension PostModalViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetIndex = targetContentOffset.pointee.x / scrollView.frame.size.width
        if targetIndex == 1 && currentIndex == 0 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = CGAffineTransform(translationX: (self.view.frame.width - 40) / 2, y: 0)
            }
            currentIndex = 1
            self.goodLabel.textColor = Asset.Colors.gray300.color
            self.badLabel.textColor = Asset.Colors.black200.color
        } else if targetIndex == 0 && currentIndex == 1 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.goodLabel.textColor = Asset.Colors.black200.color
            self.badLabel.textColor = Asset.Colors.gray300.color
        }
    }
}

extension PostModalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - UICollectionView DataSource
extension PostModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostModalGoodCollectionViewCell.className, for: indexPath) as? PostModalGoodCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.config(goodReviews: goodReviews)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostModalBadCollectionViewCell.className, for: indexPath) as? PostModalBadCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.config(badReviews: badReviews)
            return cell
        }
        return UICollectionViewCell()
    }
}
