//
//  ReportSentenceViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

final class ReportSentenceViewController: UIViewController {

    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    private var reportSentneceView = ReportSentenceView()
    private lazy var monthPicker = MonthYearPickerView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
//        reportTopView.monthButton.inputAccessoryView = setupToolbar()
        reportTopView.monthButton.inputView = monthPicker
        
        reportTopView.reportTitle = "유형별 한 줄 리뷰 순위"
        reportTopView.reportDescription = "유형 카드를 탭하여 확인해보세요"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportSentneceView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            $0.height.equalTo(146)
        }
        
        reportSentneceView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.height.equalTo(290)
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

    @objc func touchupDoneButton() {
        reportTopView.monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        view.endEditing(true)
    }
}

// MARK: - ReportTopView Delegate

extension ReportSentenceViewController: ReportTopViewDelegate {
    func touchupMonthButton() {
        
    }
}
