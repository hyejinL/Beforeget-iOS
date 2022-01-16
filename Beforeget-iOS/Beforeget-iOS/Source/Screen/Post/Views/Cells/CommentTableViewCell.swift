//
//  CommentTableViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then
import SwiftUI

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
    
    private let commentView = UIView().then {
        $0.layer.borderColor = Asset.Colors.gray300.color.cgColor
        $0.layer.borderWidth = 1
        $0.makeRound(radius: 5)
    }
    
    private lazy var commentTextView = UITextView().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body6
        $0.isScrollEnabled = false
        $0.delegate = self
    }
    
    private let letterCountLabel = UILabel().then {
        $0.text = "0 / 100"
        $0.font = BDSFont.body10
        $0.textColor = Asset.Colors.gray200.color
    }
    
    private let maxHeight: CGFloat = 118
    private lazy var minHeight: CGFloat = 40
    
    
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
                                 commentView,
                                 commentTextView,
                                 placeHolderLabel,
                                 letterCountLabel])
        
        commentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview()
        }
        
        commentView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(118)
        }
        
        commentTextView.snp.makeConstraints {
            $0.top.bottom.equalTo(commentView).inset(5)
            $0.leading.trailing.equalTo(commentView).inset(16)
        }
        
        placeHolderLabel.snp.makeConstraints {
            $0.top.equalTo(commentView.snp.top).offset(11)
            $0.leading.equalTo(commentTextView.snp.leading)
        }
        
        letterCountLabel.snp.makeConstraints {
            $0.top.equalTo(commentView.snp.bottom).offset(7)
            $0.bottom.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    func setToolBar(_ toolBar: UIToolbar) {
        commentTextView.inputAccessoryView = toolBar
    }
}

extension CommentTableViewCell: UITextViewDelegate {
    private func setupTextView() {
        self.commentTextView.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
        commentView.layer.borderColor = Asset.Colors.gray300.color.cgColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderLabel.isHidden = true
        commentView.layer.borderColor = Asset.Colors.black200.color.cgColor
    }
    
    func textViewDidChange(_ textView: UITextView) {
        letterCountLabel.text = "\(commentTextView.text.count) / 100"
        
        if commentTextView.text.count > 100 {
            commentTextView.deleteBackward()
        }
    }
}
