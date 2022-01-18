//
//  WriteTextTableViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

//MARK: - protocol

protocol WriteTextTableViewCellDelegate: AnyObject {
    func updateTextViewHeight(_ cell: WriteTextTableViewCell,_ textView: UITextView)
}

class WriteTextTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    enum MovieRecommendItem {
        static let qutoes = "명대사"
        static let director = "감독"
        static let actor = "배우"
        static let genre = "장르"
        static let summary = "줄거리"
        static let ost = "OST"
        static let text = "text"
    }
    
    // MARK: - Properties
    
    private let commentTextField = UITextField().then {
        $0.text = "코멘트"
        $0.placeholder = "추가하고 싶은 항목 이름을 적어주세요"
        $0.font = BDSFont.body2
        $0.textColor = Asset.Colors.black200.color
    }
    
    private let placeHolderLabel = UILabel().then {
        $0.text = "영화를 보며 어떤 생각을 했나요?"
        $0.font = BDSFont.body6
        $0.textColor = Asset.Colors.gray200.color
    }
    
    private lazy var commentTextView = UITextView().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body6
        $0.isScrollEnabled = false
        $0.layer.borderColor = Asset.Colors.gray300.color.cgColor
        $0.layer.borderWidth = 1
        $0.makeRound(radius: 5)
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 13, bottom: 14, right: 13)
        $0.sizeToFit()
        $0.delegate = self
    }
    
    private let letterCountLabel = UILabel().then {
        $0.text = "0 / 100"
        $0.font = BDSFont.body10
        $0.textColor = Asset.Colors.gray200.color
    }
    
    weak var delegate: WriteTextTableViewCellDelegate?
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        commentTextField.isUserInteractionEnabled = true
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([commentTextField,
                                 commentTextView,
                                 placeHolderLabel,
                                 letterCountLabel])
        
        commentTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(commentTextField.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(46)
        }
        
        placeHolderLabel.snp.makeConstraints {
            $0.top.equalTo(commentTextView.snp.top).offset(14)
            $0.leading.equalTo(commentTextView.snp.leading).inset(13)
        }
        
        letterCountLabel.snp.makeConstraints {
            $0.top.equalTo(commentTextView.snp.bottom).offset(7)
            $0.bottom.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Custom Method
    
    func setupTitle(title: String) {
        commentTextField.text = title
    }
    
    func setupTextFieldEditable() {
        commentTextField.isUserInteractionEnabled.toggle()
    }
    
    func setupPlaceHolderText(_ mediaText: String) {
        var placeHolderText: String
        switch mediaText {
        case MovieRecommendItem.qutoes:
            placeHolderText = "어떤 대사가 기억에 남나요?"
        case MovieRecommendItem.director:
            placeHolderText = "영화의 감독은 누구인가요?"
        case MovieRecommendItem.actor:
            placeHolderText = "누가 영화에 출연했나요?"
        case MovieRecommendItem.genre:
            placeHolderText = "영화의 장르는 무엇인가요?"
        case MovieRecommendItem.summary:
            placeHolderText = "영화의 줄거리는 무엇인가요?"
        case MovieRecommendItem.ost:
            placeHolderText = "마음에 드는 영화의 OST는 무엇이었나요?"
        case MovieRecommendItem.text:
            placeHolderText = "어떤 내용을 추가하고 싶나요?"
        default:
            placeHolderText = ""
        }
        
        placeHolderLabel.text = placeHolderText
    }
    
    func hideLetterCountLabel() {
        letterCountLabel.isHidden = true
    }
}

extension WriteTextTableViewCell: UITextViewDelegate {
    private func setupTextView() {
        self.commentTextView.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
        commentTextView.layer.borderColor = Asset.Colors.gray300.color.cgColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
        commentTextView.layer.borderColor = Asset.Colors.black200.color.cgColor
    }
    
    func textViewDidChange(_ textView: UITextView) {
        letterCountLabel.text = "\(commentTextView.text.count) / 100"
        
        if commentTextView.text.count > 100 {
            commentTextView.deleteBackward()
        }
        
        if let delegate = delegate {
            delegate.updateTextViewHeight(self, textView)
        }
        
        let size = CGSize(width: contentView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
