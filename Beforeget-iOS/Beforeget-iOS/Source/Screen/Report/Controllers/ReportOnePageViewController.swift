//
//  ReportOnePageViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

final class ReportOnePageViewController: UIViewController {

    // MARK: - Properties
    
    private var monthButton = RespondingButton().then {
        $0.setTitle("2021년 12월", for: .normal)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.addTarget(self, action: #selector(touchupMonthButton), for: .touchUpInside)
        $0.titleLabel?.font = BDSFont.enBody7
    }
    
    var reportOnePageView = ReportOnePageView()
    private var monthPicker = MonthYearPickerView()
    
    private var sentence: [String] = ["눈물 좔좔 호수", "눈물 좔좔 호수강", "눈물 좔좔 호수짱"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        monthButton.inputAccessoryView = setupToolbar()
        monthButton.inputView = monthPicker
        
        monthButton.layer.borderWidth = 1
        monthButton.layer.borderColor = Asset.Colors.gray200.color.cgColor
        monthButton.makeRound(radius: 31 / 2)
    }
    
    private func setupLayout() {
        view.addSubviews([monthButton, reportOnePageView])
        
        monthButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(132)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(73)
            $0.height.equalTo(31)
        }
        
        reportOnePageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(monthButton.snp.bottom).offset(26)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
        }
    }
    
    // MARK: - TODO REMOVE
    
    private func bind() {
        reportOnePageView.firstRankingMedia = "Book"
        reportOnePageView.firstRankingCount = 22
        
        reportOnePageView.secondRankingMedia = "Music"
        reportOnePageView.secondRankingCount = 10
        
        reportOnePageView.thirdRankingMedia = "Movie"
        reportOnePageView.thirdRankingCount = 7
        
        reportOnePageView.sentence = sentence
    }
    
    // MARK: - Custom Method
    
    private func setupToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = Asset.Colors.white.color
        toolbar.tintColor = Asset.Colors.black200.color
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchupDoneButton))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    // MARK: - @objc
    
    @objc func touchupMonthButton() {
        
    }
    
    @objc func touchupDoneButton() {
        monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        view.endEditing(true)
    }
}
