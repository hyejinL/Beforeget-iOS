//
//  OneLineReviewTableViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class OneLineReviewTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let oneLineReviewLabel = UILabel().then {
        $0.text = "한 줄 리뷰"
        $0.font = BDSFont.body2
        $0.textColor = Asset.Colors.black200.color
    }
    
    private let starImage = UIImageView().then {
        $0.image = Asset.Assets.icnTextStar.image
    }
    
    private lazy var addReviewCircleButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "리뷰 추가"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = BDSFont.body8
            outgoing.foregroundColor = Asset.Colors.black200.color
            return outgoing
        }
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 35, bottom: 10, trailing: 35)
        
        $0.configuration = config
        $0.layer.cornerRadius = 18
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.black200.color.cgColor
        $0.addTarget(self, action: #selector(touchupAddButton), for: .touchUpInside)
    }
    
    private let addReviewButton = UIButton().then {
        $0.setTitle("+ 리뷰 추가", for: .normal)
        $0.setTitleColor(Asset.Colors.gray200.color, for: .normal)
        $0.titleLabel?.font = BDSFont.body7
        $0.sizeToFit()
        $0.isHidden = true
        $0.addTarget(self, action: #selector(touchupAddButton), for: .touchUpInside)
    }
    
    private let collectionViewLayout = LeftAlignmentCollectionViewFlowLayout()
    
    private lazy var oneLineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.isHidden = true
        $0.contentInset = .zero
        
        $0.delegate = self
        $0.dataSource = self
        OneLineTextCollectionViewCell.register(target: $0)
    }
    
    var oneLines: [String] = []
    var presentOneLineViewController: ((_ viewController: OneLineViewController) -> ())?
    
    // MARK: - Life Cycle
    
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
        backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        contentView.addSubviews([oneLineReviewLabel,
                                 starImage,
                                 oneLineCollectionView,
                                 addReviewButton,
                                 addReviewCircleButton])
        
        oneLineReviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview()
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(oneLineReviewLabel.snp.top)
            $0.leading.equalTo(oneLineReviewLabel.snp.trailing).offset(2)
        }
        
        addReviewButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(oneLineReviewLabel.snp.centerY)
        }
        
        addReviewCircleButton.snp.makeConstraints {
            $0.top.equalTo(oneLineReviewLabel.snp.bottom).offset(17)
            $0.bottom.equalToSuperview().inset(31)
            $0.centerX.equalToSuperview()
        }
        
        oneLineCollectionView.snp.makeConstraints {
            $0.top.equalTo(oneLineReviewLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(31)
            $0.height.equalTo(39)
        }
    }
    
    //MARK: - Custom Method
    
    func isHiddenAddReviewCircleButton(_ value: Bool) {
        addReviewCircleButton.isHidden = value
    }
    
    func isHiddenAddReviewButton(_ value: Bool) {
        addReviewButton.isHidden = value
    }
    
    func isHiddenColletionView(_ value: Bool) {
        oneLineCollectionView.isHidden = value
    }
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = BDSFont.body8
        label.sizeToFit()
        return label.frame.width + 42
    }
    
    func reloadCollectionView() {
        var height = 0
        
        oneLineCollectionView.reloadData()
        if oneLines.count <= 2 {
            height = 35
        } else if oneLines.count <= 4 {
            height = 35 * 2 + 10
        } else {
            height = 35 * 3 + 10 * 2
        }
        
        oneLineCollectionView.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        
    }
    
    func getCollectionViewSize() -> CGSize {
        return oneLineCollectionView.bounds.size
    }
    
    //MARK: - @objc
    
    @objc func touchupAddButton() {
        let oneLineViewController = OneLineViewController()
        oneLineViewController.modalPresentationStyle = .overCurrentContext
        presentOneLineViewController?(oneLineViewController)
    }
}

//MARK: - UICollectionViewDataSource

extension OneLineReviewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneLines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneLineTextCollectionViewCell.className, for: indexPath) as? OneLineTextCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setupCornerRadius(radius: 17)
        cell.config(oneline: oneLines[indexPath.item])
        cell.showDeleteButton()
        cell.configColor(borderColor: Asset.Colors.black200.color, textColor: Asset.Colors.black200.color, backgroundColor: Asset.Colors.white.color)
        cell.deleteOneLine = {
            collectionView.deleteItems(at: [IndexPath(row: indexPath.item, section: 0)])
            let deletingIndex = self.oneLines.firstIndex(of: self.oneLines[indexPath.item]) ?? -1
            self.oneLines.remove(at: deletingIndex)
            self.reloadCollectionView()
            NotificationCenter.default.post(name: NSNotification.Name.didAddOneLine, object: self.oneLines)
            
            if self.oneLines.isEmpty {
                self.addReviewCircleButton.isHidden = false
                self.addReviewButton.isHidden = true
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OneLineReviewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(text: oneLines[indexPath.item]) + 15, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
