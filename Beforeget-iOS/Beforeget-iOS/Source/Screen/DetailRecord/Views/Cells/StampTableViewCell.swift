//
//  StampTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class StampTableViewCell: UITableViewCell, UITableViewRegisterable{

    // MARK: - Properties
    
    private var stampArray: [String] = ["13:45", "12:13", "04:24"]
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "타임스탬프"
    }
    
    private let customFlowLayout = LeftAlignmentCollectionViewFlowLayout()
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var stampCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: customFlowLayout).then {
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            StampCollectionViewCell.register(target: $0)
        }
        
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 stampCollectionView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        stampCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(86)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension StampTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let stampCell = collectionView.dequeueReusableCell(withReuseIdentifier: StampCollectionViewCell.className, for: indexPath) as? StampCollectionViewCell else { return UICollectionViewCell() }
        stampCell.config(stampArray[indexPath.item])
        return stampCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StampTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let stampCell = collectionView.dequeueReusableCell(withReuseIdentifier: StampCollectionViewCell.className, for: indexPath) as? StampCollectionViewCell else { return .zero }

        stampCell.stampLabel.text = stampArray[indexPath.item]
        stampCell.stampLabel.sizeToFit()
        let cellWidth = stampCell.stampLabel.frame.width + 32

        return CGSize(width: cellWidth, height: 37)
    }
}
