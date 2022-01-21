//
//  GenreTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class GenreTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private var genreArray: [String] = ["액션느와르", "로맨스코미디", "스릴러", "SF공상과학", "하이퍼리얼리즘", "모험"]
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "장르제목"
    }
    
    private let customFlowLayout = LeftAlignmentCollectionViewFlowLayout()
    
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var genreCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: customFlowLayout).then {
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            GenreCollectionViewCell.register(target: $0)
        }
    
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
        DispatchQueue.main.async {
            self.genreCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubviews([titleLabel,
                     genreCollectionView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
//            make.height.equalTo(23)
        }
        
        genreCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
            make.height.equalTo(84)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension GenreTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.className, for: indexPath) as? GenreCollectionViewCell else { return UICollectionViewCell() }
        genreCell.config(genreArray[indexPath.row])
        return genreCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GenreTableViewCell: UICollectionViewDelegateFlowLayout {
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
        
        guard let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.className, for: indexPath) as? GenreCollectionViewCell else { return .zero }
        
        genreCell.genreLabel.text = genreArray[indexPath.item]
        genreCell.genreLabel.sizeToFit()
        let cellWidth = genreCell.genreLabel.frame.width + 32
        
        return CGSize(width: cellWidth, height: 37)
    }
}
