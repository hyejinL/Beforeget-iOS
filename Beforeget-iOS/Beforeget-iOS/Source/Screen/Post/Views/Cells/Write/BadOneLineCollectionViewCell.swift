//
//  PostModalBadCollectionViewCell.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class BadOneLineCollectionViewCell: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    private let reviewTextLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var oneLineTextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reviewTextLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.isScrollEnabled = false
        
        OneLineTextCollectionViewCell.register(target: $0)
        $0.delegate = self
        $0.dataSource = self
        $0.allowsMultipleSelection = true
    }
    
    private var badReviews = [String]()
    var selectedBadReview: ((_ badReview: String) -> ())?
    
    // MARK: - Initializser
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
        getNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        addSubview(oneLineTextCollectionView)
        
        oneLineTextCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
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
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(touchupResetButton), name: NSNotification.Name("touchupOneLineResetButton"), object: nil)
    }
    
    public func config(badReviews: [String]) {
        self.badReviews = badReviews
    }
    
    // MARK: - @objc
    
    @objc func touchupResetButton() {
        oneLineTextCollectionView.deselectAllItems()
    }
}

// MARK: - UICollectionViewDelegate FlowLayout

extension BadOneLineCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(text: badReviews[indexPath.item]), height: 39)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 21, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
}

// MARK: - UICollectionViewDataSource

extension BadOneLineCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneLineTextCollectionViewCell.className, for: indexPath) as? OneLineTextCollectionViewCell else { return UICollectionViewCell() }
        cell.config(oneline: badReviews[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension BadOneLineCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedBadReviews.append(badReviews[indexPath.item])
        selectedBadReview?(badReviews[indexPath.item])
    }
}
