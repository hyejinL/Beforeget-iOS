//
//  FilterModalViewController.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

final class FilterModalViewController: UIViewController, SelectMenuDelegate {
    
    // MARK: - Properties
    
    private var modalViewTopConstraint: NSLayoutConstraint!
    
    private let height: CGFloat = 633
    
    private let dimmedView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private let modalView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.makeRound(radius: 15)
        $0.layer.maskedCorners =
        [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let indicatorView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    private lazy var menuBarView = MenuBarView().then {
        $0.selectMenuDelegate = self
    }
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var filterCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: layout).then {
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.delegate = self
            $0.dataSource = self
            FilterCollectionViewCell.register(target: $0)
            MediaCollectionViewCell.register(target: $0)
            StarCollectionViewCell.register(target: $0)
        }

    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 14
        $0.addArrangedSubviews([
            resetButton,
            applyButton])
    }
    
    public var resetButton = UIButton().then {
        $0.setImage(Asset.Assets.btnRefreshAll.image, for: .normal)
    }
    
    public var applyButton = BDSButton().then {
        $0.text = "적용"
        $0.isDisabled = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    // MARK: - InitUI
    
    private func setupLayout() {
        view.addSubviews([dimmedView, modalView])
        modalView.addSubviews([indicatorView,
                               menuBarView,
                               filterCollectionView,
                               buttonStackView])
        
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
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(9)
            make.width.equalTo(44)
            make.height.equalTo(4)
            make.centerX.equalToSuperview()
        }
        
        menuBarView.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom).inset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }

        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(459)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(menuBarView.snp.bottom).offset(459)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(76)
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(76)
        }
    }

    // MARK: - Custom Method
    
    /// 메뉴를 눌렀을 때 필터 컬렉션뷰를 해당 페이지로 이동해주기 (스크롤시켜주기) 위한 메소드
    func selectMenu(index: Int) {
        let index = IndexPath(row: index, section: 0)
        filterCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        modalViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - height
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        modalViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(
            target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(
            target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }

    // MARK: - @objc
    
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FilterModalViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let menuWidth = (UIScreen.main.bounds.width - 75*2 - 39*2)/3
        let menuIndex = round(scrollView.contentOffset.x)/(UIScreen.main.bounds.width)
        
        menuBarView.indicatorView.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(menuIndex*menuWidth+75+menuIndex*39)
        }
        
        switch menuIndex {
        case 0.0:
            return resetButton.setImage(Asset.Assets.btnRefreshAll.image, for: .normal)
        case 1.0:
            return resetButton.setImage(Asset.Assets.btnRefreshMedia.image, for: .normal)
        case 2.0:
            return resetButton.setImage(Asset.Assets.btnRefreshStar.image, for: .normal)
        default:
            return
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        menuBarView.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionViewDataSource

extension FilterModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let filterCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FilterCollectionViewCell.className,
                for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            return filterCell
        case 1:
            guard let mediaCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MediaCollectionViewCell.className,
                for: indexPath) as? MediaCollectionViewCell else { return UICollectionViewCell() }
            return mediaCell
        default:
            guard let starCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StarCollectionViewCell.className,
                for: indexPath) as? StarCollectionViewCell else { return UICollectionViewCell() }
            return starCell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FilterModalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.filterCollectionView.frame.height)
    }
}
