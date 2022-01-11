//
//  ReportLabelViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/08.
//

import UIKit

import SnapKit
import Then

final class ReportLabelViewController: UIViewController {
    
    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    private var typeImageView = UIImageView().then {
        // 이미지 추가 
        $0.contentMode = .scaleAspectFill
    }
    private var reportDescriptionView = ReportDescriptionView()
    private var monthPicker = MonthYearPickerView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        setupStatusBar(.white)
        
        reportTopView.monthButton.inputAccessoryView = setupToolbar()
        reportTopView.monthButton.inputView = monthPicker
        
        reportTopView.reportTitle = "12월의 땅콩님은?"
        reportTopView.reportDescription = "이번 달 나의 소비 유형을 알아보세요"
        
        reportDescriptionView.descriptionTitle = "티키타카 뮤지션"
        reportDescriptionView.descriptionContent = """
                                                하루의 시작과 끝을 음악과 함께하시는군요!
                                                이번 달 음악 기록이 가장 많은 당신,
                                                오늘은 어떤 음악이 당신의 하루를 채웠나요?
                                                다음 달의 땅콩님의 유형을 기대해보세요
                                                """
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, typeImageView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(146)
        }
        
        typeImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
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
    }
    
    private func setupToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = .white
        toolbar.tintColor = Asset.Colors.black200.color
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchupDoneButton))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    // MARK: - @objc
    
    @objc
    func touchupDoneButton() {
        reportTopView.monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        view.endEditing(true)
    }
}

// MARK: - ReportTopView Delegate

extension ReportLabelViewController: ReportTopViewDelegate {
    func touchupMonthButton() {
        
    }
}
