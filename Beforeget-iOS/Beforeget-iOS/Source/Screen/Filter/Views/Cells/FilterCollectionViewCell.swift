//
//  DateFilterCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Filter>! = nil
    
    private lazy var dateCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: setupCollectionViewLayout()
    )

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configDataSource()
        applySnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func setupLayout() {
        contentView.addSubviews([dateCollectionView])
        
        dateCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(142)
        }
    }
}

// MARK: - Custom Method

extension FilterCollectionViewCell {
    private func setupCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(37))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item, count: 2)
        let spacing = CGFloat(11)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 19, leading: 21,
            bottom: 37, trailing: 21)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Configure Data

extension FilterCollectionViewCell {
    private func configDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<FilterButtonCollectionViewCell, Filter> {
            (cell, indexPath, menu) in
            cell.menu = menu
            cell.isStarHidden = true
            cell.isCellSelected = true
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Filter>(collectionView: dateCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Filter) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Filter>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Filter.dateMenu, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
