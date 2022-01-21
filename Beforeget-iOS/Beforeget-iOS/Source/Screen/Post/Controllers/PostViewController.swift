//
//  PostViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then

class PostViewController: UIViewController {
    
    //MARK: - Network
    
    private let postAPI = PostAPI.shared
    
    // MARK: - Properties
    
    private lazy var navigationBar = BDSNavigationBar(self, view: .write, isHidden: false, mediaType: mediaType ?? .movie).then {
        $0.backButton.isHidden = true
    }
    
    private let backButton = UIButton().then {
        $0.setImage(Asset.Assets.btnBack.image, for: .normal)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.addTarget(self, action: #selector(touchupBackButton), for: .touchUpInside)
    }
    
    private let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.addTarget(self, action: #selector(touchupDoneButton), for: .touchUpInside)
    }
    
    private lazy var writingTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.sectionHeaderTopPadding = 0
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.estimatedRowHeight = 200
        $0.rowHeight = UITableView.automaticDimension
        $0.delegate = self
        $0.dataSource = self
        WriteTextTableViewCell.register(target: $0)
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .inline
        $0.backgroundColor = Asset.Colors.white.color
        $0.makeRound(radius: 8)
        $0.addTarget(self, action: #selector(handelDatePicker(_:)), for: .valueChanged)
    }
    
    private let bottomBarView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private let bottomBarLineview = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    private lazy var bottomBarStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.addArrangedSubviews([bottomBarLineview, bottomBarView])
    }
    
    private let addItemButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "기록항목 추가"
        config.image = Asset.Assets.icnAddItem.image
        config.imagePadding = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseForegroundColor = Asset.Colors.black200.color
        $0.configuration = config
        $0.addTarget(self, action: #selector(touchupAddItemButton), for: .touchUpInside)
    }
    
    private let deleteItemButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "기록항목 삭제"
        config.image = Asset.Assets.icnEdit.image
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseForegroundColor = Asset.Colors.black200.color
        $0.configuration = config
    }
    
    private lazy var hideKeyboardButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = Asset.Assets.btnKeyboard.image
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        $0.configuration = config
        $0.isHidden = true
        $0.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
    }
    
    private var starRating: Int = 0
    private var mediaTitle: String = ""
    private var comment: String = ""
    
    var additionalItems: [Additional] = []
    var oneLines: [String] = []
    var mediaType: MediaType?
    var oneLineCellHeight: CGFloat = 117
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        setupKeyboardNotifications()
        setupOneLineNotification()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([navigationBar,
                          backButton,
                          doneButton,
                          writingTableView,
                          bottomBarStackView,
                          addItemButton,
                          deleteItemButton,
                          hideKeyboardButton])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.top).inset(6)
            $0.leading.equalTo(navigationBar.snp.leading).inset(4)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.top).inset(6)
            $0.trailing.equalTo(navigationBar.snp.trailing).inset(13)
        }
        
        writingTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(bottomBarStackView.snp.top)
        }
        
        bottomBarLineview.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        bottomBarView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        bottomBarStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        view.keyboardLayoutGuide.snp.makeConstraints {
            $0.top.equalTo(bottomBarView.snp.bottom)
        }
        
        addItemButton.snp.makeConstraints {
            $0.centerY.equalTo(bottomBarView.snp.centerY)
            $0.leading.equalTo(bottomBarView.snp.leading).inset(18)
        }
        
        deleteItemButton.snp.makeConstraints {
            $0.centerY.equalTo(bottomBarView.snp.centerY)
            $0.leading.equalTo(addItemButton.snp.trailing).offset(15)
        }
        
        hideKeyboardButton.snp.makeConstraints {
            $0.trailing.equalTo(bottomBarView.snp.trailing).inset(10)
            $0.centerY.equalTo(bottomBarView.snp.centerY)
        }
    }
    
    //MARK: - @objc
    
    @objc func handelDatePicker(_ sender: UIDatePicker) {
        [backgroundView, datePicker].forEach {
            $0.isHidden = true
        }
        NotificationCenter.default.post(name: Notification.Name.didReceiveDate, object: sender.date)
    }
    
    @objc func touchupAddItemButton() {
        let addItemViewController = AddItemViewController()
        addItemViewController.modalPresentationStyle = .overCurrentContext
        addItemViewController.mediaType = mediaType
        definesPresentationContext = true
        present(addItemViewController, animated: true, completion: nil)
    }
    
    @objc func addOneLine(_ sender: Notification) {
        guard let oneLineData = sender.object as? [String] else { return }
        guard let cell = writingTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? OneLineReviewTableViewCell else { return }
        
        oneLineData.forEach {
            if !cell.oneLines.contains($0) {
                cell.oneLines.append($0)
            }
        }
        
        if cell.oneLines.isEmpty == false {
            cell.reloadCollectionView()
            cell.setupHidden(addReviewCircleButtonIsHidden: true,
                             addReviewButtonIsHidden: false,
                             oneLineCollectionViewIsHidden: false)
        }
        
        let collectionViewSize = cell.getCollectionViewSize()
        let estimatedSize = writingTableView.sizeThatFits(CGSize(width: collectionViewSize.width,
                                                                 height: CGFloat.greatestFiniteMagnitude))
        if collectionViewSize.height != estimatedSize.height {
            UIView.setAnimationsEnabled(false)
            writingTableView.beginUpdates()
            writingTableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    @objc func touchupBackButton() {
        if !mediaTitle.isEmpty || !oneLines.isEmpty || !comment.isEmpty || !additionalItems.isEmpty {
            let backPopupViewController = PostBackPopupViewController()
            backPopupViewController.modalPresentationStyle = .overCurrentContext
            definesPresentationContext = true
            present(backPopupViewController, animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func touchupDoneButton() {
        if starRating == 0 || mediaTitle.isEmpty || oneLines.isEmpty {
            let alert = UIAlertController(title: PopupText.requiredField, message: "", preferredStyle: UIAlertController.Style.alert)
            let doneAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(doneAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let totalAdditionalItems = additionalItems.filter { !$0.type.isEmpty }
                                                  .filter { !$0.content.isEmpty }
        
        postAPI.postRecord(record: PostRequest(media: mediaType?.mediaNumber() ?? 1,
                                               date: datePicker.date.convertToString(dateFormat: "YYYY-MM-dd"),
                                               star: starRating,
                                               title: mediaTitle,
                                               oneline: oneLines,
                                               comment: comment,
                                               additional: totalAdditionalItems)) { data, err in
            guard let data = data else { return }
            print(data)
        }
        navigationController?.pushViewController(CompleteViewController(), animated: true)
    }
    
    @objc func hideDatePicker() {
        [backgroundView, datePicker].forEach {
            $0.isHidden = true
        }
    }
    
    //MARK: - Custom Method
    
    func reloadTableView() {
        writingTableView.reloadData()
    }
    
    private func setupOneLineNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(addOneLine(_:)), name: NSNotification.Name.didAddOneLine, object: nil)
    }
}

//MARK: - UITableViewDataSource

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + additionalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let titleCell = TitleTableViewCell()
            titleCell.configContent(content: mediaTitle)
            titleCell.sendTitle = { title in
                self.mediaTitle = title
            }
            titleCell.selectionStyle = .none
            return titleCell
        case 1:
            let oneLineCell = OneLineReviewTableViewCell()
            oneLineCell.oneLines = oneLines
            oneLineCell.setupHidden(addReviewCircleButtonIsHidden: !oneLines.isEmpty ? true : false,
                                    addReviewButtonIsHidden: oneLines.isEmpty ? true : false,
                                    oneLineCollectionViewIsHidden: oneLines.isEmpty ? true : false)
            oneLineCell.presentOneLineViewController = { (_ viewController: OneLineViewController) -> () in
                viewController.mediaType = self.mediaType
                self.definesPresentationContext = true
                self.present(viewController, animated: false, completion: nil)
            }
            oneLineCell.selectionStyle = .none
            return oneLineCell
        case 2:
            let commentCell = WriteTextTableViewCell()
            commentCell.delegate = self
            commentCell.configTextFieldEditable()
            commentCell.selectionStyle = .none
            commentCell.configContent(content: comment)
            commentCell.sendContent = { comment in
                self.comment = comment
            }
            return commentCell
        default:
            guard let textCell = tableView.dequeueReusableCell(withIdentifier: WriteTextTableViewCell.className, for: indexPath) as? WriteTextTableViewCell else { return UITableViewCell() }
            textCell.delegate = self
            textCell.hideLetterCountLabel()
            textCell.configPlaceHolderText(additionalItems[indexPath.row-3].type)
            textCell.selectionStyle = .none
            
            textCell.configContent(content: additionalItems[indexPath.row-3].content)
            if additionalItems[indexPath.row-3].type == "text" {
                textCell.configTitle(title: "")
            } else {
                textCell.configTitle(title: additionalItems[indexPath.row-3].type)
                textCell.configTextFieldEditable()
            }
            
            textCell.sendContent = { content in
                self.additionalItems[indexPath.row-3].content = content
            }
            
            textCell.sendType = { type in
                self.additionalItems[indexPath.row-3].type = type
            }
            
            return textCell
        }
    }
}

//MARK: - UITableViewDelegate

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = WritingHeaderView()
        headerView.delegate = self
        headerView.configDate(date: datePicker.date)
        headerView.configStarButtonImage(starRating: starRating)
        headerView.sendStarRating = { starRating in
            self.starRating = starRating
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 192
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: - WriteTextTableViewCellDelegate

extension PostViewController: WriteTextTableViewCellDelegate {
    func updateTextViewHeight(_ cell: WriteTextTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let estimatedSize = writingTableView.sizeThatFits(CGSize(width: size.width,
                                                    height: CGFloat.greatestFiniteMagnitude))
        if size.height != estimatedSize.height {
            UIView.setAnimationsEnabled(false)
            writingTableView.beginUpdates()
            writingTableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}

//MARK: - KeyboardNotification

extension PostViewController {
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        hideKeyboardButton.isHidden = false
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        hideKeyboardButton.isHidden = true
    }
    
    @objc func hideKeyboard() {
        super.view.endEditing(true)
    }
}

//MARK: - WritingHeaderViewDelegate

extension PostViewController: WritingHeaderViewDelegate {
    func touchupDateButton() {
        view.addSubviews([backgroundView, datePicker])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideDatePicker))
        tap.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(tap)
        
        [backgroundView, datePicker].forEach {
            $0.isHidden = false
        }
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.centerY.equalToSuperview()
        }
    }
}
