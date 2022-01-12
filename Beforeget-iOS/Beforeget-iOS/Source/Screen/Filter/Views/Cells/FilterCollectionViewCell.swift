//
//  DateFilterCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

class FilterCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable, DatePickerDelegate {
    
    // MARK: - Properties
    
    var inputText: [String] = ["시작", "끝"]
    var inputDates: [Date] = []
    var datePickerIndexPath: IndexPath?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Filter>! = nil
    
    private lazy var dateCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: setupCollectionViewLayout()
    )
    
    private lazy var dateTableView = UITableView(frame: .zero).then {
        $0.backgroundColor = Asset.Colors.white.color
//        $0.separatorStyle = .none
        $0.delegate = self
        $0.dataSource = self
        DateTableViewCell.register(target: $0)
        DatePickerTableViewCell.register(target: $0)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCollectionView()
        addInitailValues()
        configDataSource()
        applySnapshot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func setupLayout() {
        contentView.addSubviews([dateCollectionView, lineView, dateTableView])
        
        dateCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(142)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(dateTableView.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(0.5)
        }
        
        dateTableView.snp.makeConstraints { make in
            make.top.equalTo(dateCollectionView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func setupCollectionView() {
        dateCollectionView.isScrollEnabled = false
    }
    
    func addInitailValues() {
        inputDates = Array(repeating: Date(), count: inputText.count)
    }
    
    private func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        dateTableView.reloadRows(at: [indexPath], with: .none)
    }
}

// MARK: - setupCollectionViewLayout

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
            bottom: 0, trailing: 21)
        
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

// MARK: - UITableViewDelegate

extension FilterCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deselectRow(at: indexPath, animated: false)

        if let datePickerIndexPath = datePickerIndexPath,
           datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
            
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
        }
        
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource

extension FilterCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return inputText.count + 1
        } else {
            return inputText.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath { // 동일하면 데이트피커를 반환
            guard let datePickerCell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.className, for: indexPath) as? DatePickerTableViewCell else { return UITableViewCell() }
            datePickerCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            datePickerCell.updateCell(date: inputDates[indexPath.row - 1], indexPath: indexPath)
            datePickerCell.datePickerDelegate = self
            return datePickerCell
        } else { // 동일하지 않은 경우 데이트셀을 반환해서 날짜와 제목을 반환
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.className, for: indexPath) as? DateTableViewCell else { return UITableViewCell() }
            dateCell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            dateCell.updateText(text: inputText[indexPath.row], date:  inputDates[indexPath.row])
            return dateCell
        }
    }
}
