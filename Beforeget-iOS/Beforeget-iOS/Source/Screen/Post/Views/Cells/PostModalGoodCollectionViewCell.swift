//
//  PostModalGoodCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class PostModalGoodCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    private let reviewTextLayout = LeftAlignmentCollectionViewFlowLayout()
    
    private lazy var reviewTextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reviewTextLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.isScrollEnabled = false
        
        PostModalReviewCollectionViewCell.register(target: $0)
        $0.delegate = self
        $0.dataSource = self
    }
    
    var goodReviews = [String]()
    
    // MARK: - InitUI
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        contentView.backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        addSubview(reviewTextCollectionView)
        
        reviewTextCollectionView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(21)
        }
    }
    
    // MARK: - Custom Method
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = BDSFont.body8
        label.sizeToFit()
        return label.frame.width + 42
    }
    
    public func config(goodReviews: [String]) {
        self.goodReviews = goodReviews
    }
}

// MARK: - UICollectionViewDelegate FlowLayout

extension PostModalGoodCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(text: goodReviews[indexPath.item]), height: 39)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
}

// MARK: - UICollectionViewDataSource

extension PostModalGoodCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostModalReviewCollectionViewCell.className, for: indexPath) as? PostModalReviewCollectionViewCell else { return UICollectionViewCell() }
        cell.config(oneline: goodReviews[indexPath.item])
        return cell
    }
}
