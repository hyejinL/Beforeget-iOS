//
//  DatePickerTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import UIKit

import SnapKit
import Then

// MARK: - Delegate

protocol DatePickerDelegate: AnyObject {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DatePickerTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Properties
    
    weak var datePickerDelegate: DatePickerDelegate?
    public var dateSendingClosure: ((Int, Date) -> ())?
    public var selectedDate: Date?
    
    public var indexPath: IndexPath!
    
    private let cellHeight = 186
    
    private lazy var lineStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 33
        $0.addArrangedSubviews([topLineView, bottomLineView])
    }
    
    private let topLineView = UIView()
    private let bottomLineView = UIView()
    
    public lazy var datePicker = UIDatePicker().then {
        $0.maximumDate = Date()
        $0.datePickerMode = .date
        $0.setValue(UIColor.white, forKeyPath: "textColor")
        $0.locale = Locale(identifier: "ko_KR")
        $0.timeZone = TimeZone(abbreviation: "KST")
        $0.preferredDatePickerStyle = .wheels
        $0.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        [topLineView, bottomLineView].forEach {
            $0.backgroundColor = Asset.Colors.black200.color
        }
    }
    
    private func setupLayout() {
        contentView.addSubviews([datePicker,
                                 lineStackView])
        
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(137)
            make.bottom.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
        }
        
        lineStackView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.top).inset(53)
            make.bottom.equalTo(datePicker.snp.bottom).inset(51)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
        }
        
        topLineView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func layoutSubviews() {
        datePicker.subviews[0].subviews[1].isHidden = true
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
        print("indexPath.section = \(indexPath.section), row = \(indexPath.row)")
        dateSendingClosure?(indexPath.row - 1, sender.date)
    }
}
