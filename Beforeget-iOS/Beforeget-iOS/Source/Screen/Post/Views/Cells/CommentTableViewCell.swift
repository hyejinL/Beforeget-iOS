//
//  CommentTableViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

//MARK: - protocol

protocol CommentTableViewCellDelegate: AnyObject {
    func updateTextViewHeight(_ cell: CommentTableViewCell,_ textView: UITextView)
}

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let commentLabel = UILabel().then {
        $0.text = "코멘트"
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
    
    weak var delegate: CommentTableViewCellDelegate?
    
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
        backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([commentLabel,
                                 commentTextView,
                                 placeHolderLabel,
                                 letterCountLabel])
        
        commentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(18)
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
}

extension CommentTableViewCell: UITextViewDelegate {
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
