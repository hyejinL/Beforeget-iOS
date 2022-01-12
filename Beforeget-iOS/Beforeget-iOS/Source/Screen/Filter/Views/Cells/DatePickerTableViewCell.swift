//
//  DatePickerTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

// MARK: - Delegate

protocol DatePickerDelegate: FilterCollectionViewCell {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DatePickerTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    weak var datePickerDelegate: DatePickerDelegate?
    
    public var indexPath: IndexPath!
    
    private let cellHeight = 186
    
    public lazy var datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
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
        contentView.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.leading.trailing.equalToSuperview().inset(109)
            make.height.equalTo(137)
            make.bottom.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method

    func updateCell(date: Date, indexPath: IndexPath) {
        datePicker.setDate(date, animated: true)
        self.indexPath = indexPath
    }
    
    // MARK: - @objc
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        let indexPathForDisplayDate = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        datePickerDelegate?.didChangeDate(date: sender.date, indexPath: indexPathForDisplayDate)
    }
}
