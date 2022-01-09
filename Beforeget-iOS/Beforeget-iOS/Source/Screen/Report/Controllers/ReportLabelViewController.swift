//
//  ReportLabelViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/08.
//

import UIKit

import SnapKit
import Then

class ReportLabelViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var reportTopView = ReportTopView()
    
    private lazy var typeImageView = UIImageView().then {
        $0.image = UIImage(named: " ")
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var reportDescriptionView = ReportDescriptionView()
    
    private lazy var monthPicker = MonthYearPickerView()
    
//    private lazy var monthPicker = UIDatePicker().then {
//        $0.preferredDatePickerStyle = .wheels
//        $0.datePickerMode = .date
//        $0.locale = Locale(identifier: "ko")
//        $0.maximumDate = Date()
//    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = .systemGray2
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        reportTopView.monthButton.inputAccessoryView = createToolbar()
        
        // MARK: TODO REMOVE
        reportTopView.month = "12"
        reportDescriptionView.type = "티키타카 뮤지션"
        reportDescriptionView.typeDescription = """
                                                하루의 시작과 끝을 음악과 함께하시는군요!
                                                이번 달 음악 기록이 가장 많은 당신,
                                                오늘은 어떤 음악이 당신의 하루를 채웠나요?
                                                다음 달의 땅콩님의 유형을 기대해보세요
                                                """
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, typeImageView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(151)
        }
        
        typeImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(reportTopView.snp.bottom).offset(22)
            $0.height.equalTo(290)
        }
        
        reportDescriptionView.snp.makeConstraints {
            $0.top.equalTo(typeImageView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(157)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        reportTopView.delegate = self
        
        reportTopView.monthButton.inputView = monthPicker
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .white
        toolbar.tintColor = Asset.Colors.black200.color
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchUpDoneButton))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    // MARK: - @objc

    @objc
    func touchUpDoneButton() {
        reportTopView.monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        self.view.endEditing(true)
    }
}

// MARK: - ReportTopView Delegate

extension ReportLabelViewController: ReportTopViewDelegate {
    func touchUpMonthButton() {
        reportTopView.monthButton.responder = true
        reportTopView.monthButton.becomeFirstResponder()
    }
}
