//
//  MenuBarView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Delegate

protocol SelectMenuDelegate: FilterModalViewController {
    func selectMenu(index: Int)
}

/// 필터 모달뷰에서 있는 기간, 미디어, 별점 메뉴 부분

class MenuBarView: UIView {
    
    // MARK: - Properties
    
    weak public var selectMenuDelegate: SelectMenuDelegate?
    
    public let menu = MenuMannager()
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
        
    public lazy var menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        MenuBarCollectionViewCell.register(target: $0)
    }
    
    public var indicatorView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    // MARK: - Initializers
    
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
        backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubviews([menuCollectionView,
                     lineView,
                     indicatorView])
        
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(75)
            make.trailing.equalToSuperview().inset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom)
            make.leading.equalToSuperview().inset(75)
            make.width.equalTo(50)
            make.height.equalTo(2)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MenuBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMenuDelegate?.selectMenu(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MenuBarCollectionViewCell else { return }
        cell.menuLabel.textColor = Asset.Colors.gray300.color
    }
}

// MARK: - UICollectionViewDataSource

extension MenuBarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.getMenuCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCollectionViewCell.className, for: indexPath) as? MenuBarCollectionViewCell else { return UICollectionViewCell() }
        menuCell.menuLabel.text = menu.getMenuText(index: indexPath.item)
        if indexPath.item == 0 {
            menuCell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        return menuCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuBarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 39
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 36
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = 39
        let width: CGFloat = (collectionView.bounds.width - (CGFloat(itemSpacing)*2))/3
        return CGSize(width: width, height: self.bounds.height)
    }
}
