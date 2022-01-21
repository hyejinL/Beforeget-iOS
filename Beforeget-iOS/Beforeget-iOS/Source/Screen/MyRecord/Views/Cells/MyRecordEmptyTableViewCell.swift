//
//  MyRecordEmptyTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/20.
//

import UIKit

import SnapKit
import Then

class MyRecordEmptyTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private var emptyStateImageView = UIImageView().then {
        $0.image = Asset.Assets.icnRecordEmpty.image
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupEmptyLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    public func setupEmptyLayout() {
        contentView.addSubview(emptyStateImageView)
        
        emptyStateImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(189)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
            make.height.equalTo(114)
        }
    }
}
