//
//  FilterModalViewController.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

/// 필터 버튼 선택 시에 올라오는 모달 창 + 딤처리도 같이

final class FilterModalViewController: UIViewController, SelectMenuDelegate {
    
    // MARK: - Properties
    
    private var modalViewTopConstraint: NSLayoutConstraint!
    
    private let height: CGFloat = 633 // 모달뷰 높이
    
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
    
    private let menuBarView = MenuBarView()
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var filterCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: layout).then {
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
            $0.backgroundColor = .yellow
            FilterCollectionViewCell.register(target: $0)
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
        modalView.addSubviews([indicatorView, menuBarView, filterCollectionView])
        
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
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
            make.top.equalTo(indicatorView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuBarView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        menuBarView.selectMenuDelegate = self
    }
    
    // MARK: - Custom Method
    
    func selectMenu(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.filterCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
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
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    
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
        let menuWidth = (UIScreen.main.bounds.width - 152)/3
        menuBarView.indicatorView.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(round(scrollView.contentOffset.x)/(UIScreen.main.bounds.width)*menuWidth)
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
        guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.className, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        
        return filterCell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.filterCollectionView.frame.height)
    }
}
