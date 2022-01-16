//
//  LinkTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SafariServices
import SnapKit
import Then

// MARK: - Delegate

protocol LinkButtonDelegate: DetailRecordViewController {
    func clickLinkButton(url: NSURL)
}

class LinkTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    weak var linkButtonDelegate: LinkButtonDelegate?
    
    private var cellMargin: CGFloat = 47
    
    public var linkString: String = "https://www.youtube.com/watch?v=qZFo0PYkHFo"
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "링크"
    }
    
    public lazy var linkButton = UIButton(type: .system).then {
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.setTitle(linkString, for: .normal)
        $0.addTarget(self, action: #selector(touchupLinkButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Initializer

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
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 linkButton])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(50)
        }
        
        linkButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview().inset(cellMargin)
        }
    }
    
    // MARK: - Custom Method
        
    public func config(_ link: String) {
        /// 문제 : 나중에 데이터 전달
        linkString = link
    }
    
    // MARK: - @objc
    
    @objc func touchupLinkButton(_ sender: UIButton) {
        guard let url = NSURL(string: linkString) else { return }
        linkButtonDelegate?.clickLinkButton(url: url)
    }
}
