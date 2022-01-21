//
//  PostModalViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/17.
//

import UIKit

import SnapKit
import Then

final class OneLineViewController: UIViewController {
    
    //MARK: - Network
    
    private let postAPI = PostAPI.shared
    
    // MARK: - Properties
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private var modalView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.makeRound(radius: 15)
        $0.layer.maskedCorners =
        [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
    
    private lazy var oneLineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        
        $0.delegate = self
        $0.dataSource = self
        
        GoodOneLineCollectionViewCell.register(target: $0)
        BadOneLineCollectionViewCell.register(target: $0)
    }
    
    private var countLabel = UILabel().then {
        $0.text = "0 / 6"
        $0.textColor = Asset.Colors.gray200.color
        $0.font = BDSFont.body3
    }
    
    private var resetButton = UIButton().then {
        $0.setImage(Asset.Assets.btnRefreshAll.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupResetButton), for: .touchUpInside)
    }
    
    private var applyButton = BDSButton().then {
        $0.text = "적용"
        $0.isDisabled = true
        $0.backgroundColor = Asset.Colors.gray300.color
        $0.addTarget(self, action: #selector(touchupApplyButton), for: .touchUpInside)
    }
    
    private var modalViewTopConstraint: NSLayoutConstraint!
    private let height: CGFloat = 435
    
    private var currentIndex = 0
    private var goodReviews: [String] = []
    private var badReviews: [String] = []
    private var selectedReviews: [String] = []
    private var selectedReviewCount: Int = 0
    
    var mediaType: MediaType?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        setupGestureRecognizer()
        setupNotification()
        
        self.postAPI.getOneLine(mediaId: self.mediaType?.mediaNumber() ?? 1) { [weak self] data, err in
            guard let data = data else { return }
            self?.goodReviews = data.good
            self?.badReviews = data.bad
            self?.oneLineCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        postNotification()
        let postViewController = presentingViewController as? PostViewController
        postViewController?.oneLines = selectedReviews
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.black200.color.withAlphaComponent(0.5)
    }
    
    private func setupLayout() {
        view.addSubviews([dimmedView, modalView])
        modalView.addSubviews([indicatorView,
                               goodLabel,
                               badLabel,
                               lineView,
                               statusMovedView,
                               oneLineCollectionView,
                               countLabel,
                               applyButton,
                               resetButton])
        
        let topConstant =
        view.safeAreaInsets.bottom +
        view.safeAreaLayoutGuide.layoutFrame.height
        
        modalViewTopConstraint = modalView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: topConstant)
        
        NSLayoutConstraint.activate([
            modalViewTopConstraint
        ])
        
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        modalView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
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
        
        oneLineCollectionView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(oneLineCollectionView.snp.bottom).offset(13)
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
    
    private func setupGestureRecognizer() {
        // MARK: - FIX ME : 드래그 막음
//        let tapGoodLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToGood))
//        goodLabel.addGestureRecognizer(tapGoodLabelGesture)
//        goodLabel.isUserInteractionEnabled = true
//
//        let tapBadLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToBad))
//        badLabel.addGestureRecognizer(tapBadLabelGesture)
//        badLabel.isUserInteractionEnabled = true
        
        let dimmedTap = UITapGestureRecognizer(
            target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
        
        let swipeGesture = UISwipeGestureRecognizer(
            target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        modalViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - height
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        modalViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded() }) { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: false, completion: nil)
                }
            }
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(addOneLineCount), name: Notification.Name.didSelectOneLine, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteOneLineCount), name: Notification.Name.didDeselectOneLine, object: nil)
    }
    
    private func setupApplyButton() {
        if selectedReviewCount == 0 {
            applyButton.isDisabled = true
            applyButton.backgroundColor = Asset.Colors.gray300.color
        } else {
            applyButton.isEnabled = true
            applyButton.backgroundColor = Asset.Colors.black200.color
        }
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name.didAddOneLine, object: selectedReviews)
    }
    
    // MARK: - @objc
    
    @objc func dragToGood() {
        if currentIndex == 1 {
            let indexPath = IndexPath(item: 0, section: 0)
            oneLineCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.goodLabel.textColor =  Asset.Colors.black200.color
            self.badLabel.textColor = Asset.Colors.gray200.color
        }
    }
    
    @objc func dragToBad() {
        let indexPath = IndexPath(item: 1, section: 0)
        oneLineCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if currentIndex == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = CGAffineTransform(translationX: (self.view.frame.width - 40) / 2 , y: 0)
            }
            currentIndex = 1
            self.goodLabel.textColor = Asset.Colors.gray200.color
            self.badLabel.textColor =  Asset.Colors.black200.color
        }
    }
    
    @objc func touchupResetButton() {
        NotificationCenter.default.post(name: NSNotification.Name("touchupOneLineResetButton"), object: nil)
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended, recognizer.direction == .down {
            hideBottomSheetAndGoBack()
        }
    }
    
    @objc func touchupApplyButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addOneLineCount() {
        selectedReviewCount += 1
        countLabel.text = "\(selectedReviewCount) / 6"
        setupApplyButton()
    }
    
    @objc func deleteOneLineCount() {
        selectedReviewCount -= 1
        countLabel.text = "\(selectedReviewCount) / 6"
        setupApplyButton()
    }
}

// MARK: - UICollectionView Delegate

extension OneLineViewController: UICollectionViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let targetIndex = targetContentOffset.pointee.x / scrollView.frame.size.width
//        if targetIndex == 1 && currentIndex == 0 {
//            UIView.animate(withDuration: 0.5) {
//                self.statusMovedView.transform = CGAffineTransform(translationX: (self.view.frame.width - 40) / 2, y: 0)
//            }
//            currentIndex = 1
//            self.goodLabel.textColor = Asset.Colors.gray300.color
//            self.badLabel.textColor = Asset.Colors.black200.color
//        } else if targetIndex == 0 && currentIndex == 1 {
//            UIView.animate(withDuration: 0.5) {
//                self.statusMovedView.transform = .identity
//            }
//            currentIndex = 0
//            self.goodLabel.textColor = Asset.Colors.black200.color
//            self.badLabel.textColor = Asset.Colors.gray300.color
//        }
//    }
}

// MARK: - UICollectionView DelegateFlowLayout

extension OneLineViewController: UICollectionViewDelegateFlowLayout {
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

extension OneLineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
//        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodOneLineCollectionViewCell.className, for: indexPath) as? GoodOneLineCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.reloadCollectionView()
            cell.config(goodReviews: goodReviews)
            cell.selectedGoodReview = { (goodReviews: String) -> () in
                self.selectedReviews.append(goodReviews)
            }
            return cell
        }
//        else if indexPath.row == 1 {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadOneLineCollectionViewCell.className, for: indexPath) as? BadOneLineCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            cell.config(badReviews: badReviews)
//            cell.selectedBadReview = { (badReviews: String) -> () in
//                self.selectedReviews.append(badReviews)
//            }
//            return cell
//        }
        return UICollectionViewCell()
    }
}
