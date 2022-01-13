//
//  DateFilterCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import UIKit

import SnapKit
import Then

// MARK: - Delegate

protocol DateFilterButtonDelegate: FilterModalViewController {
    func selectDateFilter(index: Int)
}

/// 필터모달 오픈 시에 데이트 피커 테이블 뷰가 있는 아이.

class FilterCollectionViewCell: UICollectionViewCell,
                                UICollectionViewRegisterable,
                                DatePickerDelegate {
    
    // MARK: - Properties
    
    private var filter = FilterManager()
    
    weak var dateFilterButtonDelegate: DateFilterButtonDelegate?
    
    var inputText: [String] = ["시작", "끝"]
    var inputDates: [Date] = []
    var datePickerIndexPath: IndexPath?
    
    public lazy var dateCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: setupCollectionViewLayout()).then {
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            FilterButtonCollectionViewCell.register(target: $0)
        }
    
    private lazy var dateTableView = UITableView(frame: .zero).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.isScrollEnabled = false
        DateTableViewCell.register(target: $0)
        DatePickerTableViewCell.register(target: $0)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
        addInitailValues()
        setupNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
    }
    
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
    
    private func addInitailValues() {
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
    
    // MARK: - Custom Method
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(resetDateFilter), name: NSNotification.Name("ResetDateFilter"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func resetDateFilter() {
        dateCollectionView.deselectAllItems(animated: false)
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

// MARK: - UICollectionViewDelegate

extension FilterCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dateFilterButtonDelegate?.selectDateFilter(index: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource

extension FilterCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.getFilterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dateFilterCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.className, for: indexPath) as? FilterButtonCollectionViewCell else { return UICollectionViewCell() }
        dateFilterCell.cellLabel.text = filter.getFilterText(index: indexPath.item)
        return dateFilterCell
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
