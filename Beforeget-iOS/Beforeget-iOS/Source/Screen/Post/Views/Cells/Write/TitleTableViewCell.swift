//
//  TitleTableViewCell.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class TitleTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.text = "영화 제목"
        $0.font = BDSFont.body2
        $0.textColor = Asset.Colors.black200.color
    }
    
    private let starImage = UIImageView().then {
        $0.image = Asset.Assets.icnTextStar.image
    }
    
    private lazy var titleTextField = UITextField().then {
        $0.textColor = Asset.Colors.black200.color
        $0.font = BDSFont.body1
        $0.attributedPlaceholder = NSAttributedString(string: "영화의 제목은 무엇인가요?", attributes: [NSAttributedString.Key.foregroundColor: Asset.Colors.gray200.color])
        $0.backgroundColor = Asset.Colors.white.color
        $0.borderStyle = .none
        $0.delegate = self
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(Asset.Assets.btnDelete.image, for: .normal)
        $0.isHidden = true
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.addTarget(self, action: #selector(touchupDeleteButton(_:)), for: .touchUpInside)
    }
    
    private lazy var titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.addArrangedSubviews([titleTextField, deleteButton])
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray300.color
    }
    
    private let letterCountLabel = UILabel().then {
        $0.text = "0 / 20"
        $0.font = BDSFont.body10
        $0.textColor = Asset.Colors.gray200.color
    }
    
    var sendTitle: ((_ title: String) -> ())?
    
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
        contentView.addSubviews([titleLabel,
                                 starImage,
                                 titleStackView,
                                 lineView,
                                 letterCountLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.leading.equalToSuperview()
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(2)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(5)
            $0.trailing.equalTo(lineView.snp.trailing)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        letterCountLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(6)
            $0.bottom.equalToSuperview().inset(4)
            $0.trailing.equalToSuperview()
        }
    }
    
    //MARK: - @objc
    
    @objc func touchupDeleteButton(_ sender: UIButton) {
        titleTextField.text = ""
    }
    
    //MARK: - Custom Method
    
    func configContent(content: String) {
        titleTextField.text = content
        letterCountLabel.text = "\(content.count) / 20"
    }
}

extension TitleTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        deleteButton.isHidden = false
        lineView.backgroundColor = Asset.Colors.black200.color
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        letterCountLabel.text = "\(text.count) / 20"
        
        if text.count > 20 {
            titleTextField.deleteBackward()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        deleteButton.isHidden = true
        lineView.backgroundColor = Asset.Colors.gray300.color
        sendTitle?(textField.text ?? "")
    }
}
