//
//  DateTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

import SnapKit
import Then

class DateTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    private let cellHeight = 20
    
    private let startEndLabel = UILabel().then {
        $0.font = BDSFont.body7
        $0.textColor = Asset.Colors.black200.color
    }
    
    public var dateLabel = UILabel().then {
        $0.font = BDSFont.body8
        $0.textColor = Asset.Colors.black200.color
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func setupLayout() {
        contentView.addSubviews([startEndLabel, dateLabel])
        
        startEndLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().inset(21)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(13)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    func updateText(text: String, date: Date) {
        startEndLabel.text = text
        dateLabel.text = date.convertToString()
    }
    
    func updateDateLabel(date: String) {
        dateLabel.text = date
    }
}

// MARK: - Date Formater

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
}
