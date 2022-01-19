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
    
    private lazy var addButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "한 줄 리뷰 추가"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = BDSFont.body8
            outgoing.foregroundColor = Asset.Colors.black200.color
            return outgoing
        }
        config.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 22, bottom: 9, trailing: 22)
        
        $0.configuration = config
        $0.layer.cornerRadius = 18
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Asset.Colors.black200.color.cgColor
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
                                 addButton])
        
        oneLineReviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview()
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(oneLineReviewLabel.snp.top)
            $0.leading.equalTo(oneLineReviewLabel.snp.trailing).offset(2)
        }
        
        addButton.snp.makeConstraints {
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
    
    func isHiddenAddButton(_ value: Bool) {
        addButton.isHidden = value
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
            height = 39
        } else if oneLines.count <= 4 {
            height = 39 * 2 + 10
        } else {
            height = 39 * 3 + 10 * 2
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
                self.addButton.isHidden = false
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OneLineReviewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(text: oneLines[indexPath.item]) + 10, height: 39)
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
