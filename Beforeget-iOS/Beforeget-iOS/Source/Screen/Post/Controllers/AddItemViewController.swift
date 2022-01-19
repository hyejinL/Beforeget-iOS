//
//  AddItemViewController.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/17.
//

import UIKit

import SnapKit
import Then

final class AddItemViewController: UIViewController {
    
    enum CollectionViewConst {
        static let cellInterval: CGFloat = 12
        static let widthCellIntervalCount: CGFloat = 2
        static let widthCellCount: CGFloat = 3
        
        static func heightCellIntervalCount(_ recommendItemsCount: Int) -> CGFloat {
            return CGFloat((recommendItemsCount / 2) - 1)
        }
        
        static func heightCellCount(_ recommendItemsCount: Int) -> CGFloat {
            let isRemainder: Bool = recommendItemsCount % 3 == 0 ? false : true
            return isRemainder ? CGFloat((recommendItemsCount / 3) + 1) : CGFloat(recommendItemsCount / 3)
        }
    }
    
    // MARK: - Network
    
    private let postAPI = PostAPI.shared
    
    // MARK: - Properties
    
    private let topBarView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private let closeButton = UIButton().then {
        $0.setImage(Asset.Assets.btnClose.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupCloseButton), for: .touchUpInside)
    }
    
    private let recommendMessageLabel = UILabel().then {
        $0.text = "이런 내용을 기록해 보는 건 어때요?"
        $0.font = BDSFont.title5
        $0.textColor = Asset.Colors.black200.color
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = CollectionViewConst.cellInterval
        $0.minimumInteritemSpacing = CollectionViewConst.cellInterval
    }
    
    private lazy var recommendItemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
        AddItemCollectionViewCell.register(target: $0)
        $0.delegate = self
        $0.dataSource = self
    }
    
    private let moreRecommendMessageLabel = UILabel().then {
        $0.text = "더 기록해보고 싶은 내용이 있나요?"
        $0.font = BDSFont.title5
        $0.textColor = Asset.Colors.black200.color
    }
    
    private let addTextButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        var title = AttributeContainer()
        title.font = BDSFont.body5
        config.attributedTitle = AttributedString("직접 텍스트 항목을 추가할 수 있어요.", attributes: title)
        config.image = Asset.Assets.icnCheckInactive.image
        config.imagePadding = 13
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 60)
        config.baseForegroundColor = Asset.Colors.black200.color
        $0.configuration = config
        $0.makeRound()
        $0.layer.borderColor = Asset.Colors.gray400.color.cgColor
        $0.layer.borderWidth = 2
        $0.addTarget(self, action: #selector(touchupAddTextButton), for: .touchUpInside)
    }
    
    private let addImageButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        var title = AttributeContainer()
        title.font = BDSFont.body5
        config.attributedTitle = AttributedString("직접 이미지 항목을 추가할 수 있어요.", attributes: title)
        config.image = Asset.Assets.icnCheckInactive.image
        config.imagePadding = 13
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 60)
        config.baseForegroundColor = Asset.Colors.black200.color
        $0.configuration = config
        $0.makeRound()
        $0.layer.borderColor = Asset.Colors.gray400.color.cgColor
        $0.layer.borderWidth = 2
    }
    
    private let exampleImageView = UIImageView().then {
        $0.image = Asset.Assets.imgExample.image
        $0.isHidden = true
    }
    
    private let addButton = UIButton().then {
        $0.backgroundColor = Asset.Colors.gray300.color
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(Asset.Colors.white.color, for: .normal)
        $0.titleLabel?.font = BDSFont.title6
        $0.makeRound(radius: 4)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(touchupAddButton), for: .touchUpInside)
    }
    
    var isSelectedAddTextButton: Bool = false
    var isSelectedAddImageButton: Bool = false
    var selectedItemCount: Int = 0
    var recommendItems: [String] = []
    var selectedItems: [String] = []
    var mediaType: MediaType?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        postAPI.getRecommendItem(mediaId: mediaType?.mediaNumber() ?? 1) { [weak self] data, err in
            guard let data = data else { return }
            self?.recommendItems = data.additional
            self?.recommendItemCollectionView.reloadData()
        }
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([topBarView,
                          closeButton,
                          recommendMessageLabel,
                          recommendItemCollectionView,
                          moreRecommendMessageLabel,
                          addTextButton,
                          addImageButton,
                          exampleImageView,
                          addButton])
        
        topBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(7)
            $0.centerY.equalTo(topBarView)
        }
        
        recommendMessageLabel.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(20)
        }
        
        recommendItemCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendMessageLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(21)
        }
        
        moreRecommendMessageLabel.snp.makeConstraints {
            $0.top.equalTo(recommendItemCollectionView.snp.bottom).offset(54)
            $0.leading.equalTo(recommendMessageLabel.snp.leading)
        }
        
        addTextButton.snp.makeConstraints {
            $0.top.equalTo(moreRecommendMessageLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(21)
        }
        
        addImageButton.snp.makeConstraints {
            $0.top.equalTo(addTextButton.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview().inset(21)
        }
        
        exampleImageView.snp.makeConstraints {
            $0.top.equalTo(addImageButton.snp.bottom).offset(19)
            $0.leading.trailing.equalTo(addImageButton)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(exampleImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(exampleImageView)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(54)
        }
    }
    
    //MARK: - @objc
    
    @objc func touchupAddTextButton() {
        isSelectedAddTextButton.toggle()
        if isSelectedAddTextButton {
            addTextButton.setImage(Asset.Assets.icnCheckActive.image, for: .normal)
            addTextButton.layer.borderColor = Asset.Colors.black200.color.cgColor
            selectedItemCount += 1
            addButton.backgroundColor = Asset.Colors.black200.color
            addButton.isEnabled = true
        } else {
            addTextButton.setImage(Asset.Assets.icnCheckInactive.image, for: .normal)
            addTextButton.layer.borderColor = Asset.Colors.gray400.color.cgColor
            selectedItemCount -= 1
            
            if selectedItemCount == 0 {
                addButton.backgroundColor = Asset.Colors.gray300.color
                addButton.isEnabled = false
            }
        }
        
        setupExampleImageView()
    }
    
    @objc func touchupAddButton() {
        let postViewController = presentingViewController as? PostViewController
        
        if isSelectedAddTextButton {
            selectedItems.append("text")
        }
        
        postViewController?.additionalItems.append(contentsOf: selectedItems)
        postViewController?.reloadTableView()
        dismiss(animated: true)
    }
    
    @objc func touchupCloseButton() {
        dismiss(animated: true)
    }
    
    //MARK: - Custom Method
    
    private func setupExampleImageView() {
        if isSelectedAddTextButton || isSelectedAddImageButton {
            exampleImageView.isHidden = false
        } else {
            exampleImageView.isHidden = true
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension AddItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (CollectionViewConst.cellInterval * CollectionViewConst.widthCellIntervalCount)) / CollectionViewConst.widthCellCount
        let height: CGFloat = (collectionView.frame.height - (CollectionViewConst.cellInterval * CollectionViewConst.heightCellIntervalCount(recommendItems.count))) / CollectionViewConst.heightCellCount(recommendItems.count)
        return CGSize(width: width, height: height)
    }
}

//MARK: - UICollectionViewDataSource

extension AddItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCollectionViewCell.className, for: indexPath) as? AddItemCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.config(recommendItems[indexPath.row])
        cell.item = recommendItems[indexPath.row]
        cell.itemDelegate = self
        
        return cell
    }
}

//MARK: - ItemcellDelegate

extension AddItemViewController: ItemcellDelegate {
    func itemCellSelected(_ cell: AddItemCollectionViewCell) {
        selectedItems.append(cell.item)
        addButton.backgroundColor = Asset.Colors.black200.color
        addButton.isEnabled = true
        selectedItemCount += 1
    }
    
    func itemCellUnselected(_ cell: AddItemCollectionViewCell, unselectedItemName: String) {
        let deletingIndex = selectedItems.firstIndex(of: unselectedItemName) ?? -1
        selectedItems.remove(at: deletingIndex)
        selectedItemCount -= 1
        
        if selectedItemCount == 0 {
            addButton.backgroundColor = Asset.Colors.gray300.color
            addButton.isEnabled = false
        }
    }
}
