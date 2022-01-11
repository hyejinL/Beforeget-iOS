//
//  ReportGraphViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit

final class ReportGraphViewController: UIViewController {

    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    private var reportGraphView = ReportGraphView()
    private var reportDescriptionView = ReportDescriptionView()
    private lazy var monthPicker = MonthYearPickerView()
    
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
        
        reportTopView.reportTitle = "월별 그래프"
        reportTopView.reportDescription = "가장 많은 기록을 한 달을 확인해보세요"
        
        reportDescriptionView.descriptionTitle = "13개의 기록을 남겼어요"
        reportDescriptionView.descriptionContent = """
                                                지난달 보다 4개가 늘었네요!
                                                8월부터 5개월간 가장 많은 기록을 남긴 달은
                                                10월로, 30개의 기록을 남겼어요!
                                                다음 달 나의 그래프는 어떤 모양일까요?
                                                """
        
        reportGraphView.delegate = self
        reportGraphView.month = "12월"
        reportGraphView.threeMonthSelected = false
        reportGraphView.fiveMonthSelected = true
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportGraphView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(146)
        }
        
        reportGraphView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.height.equalTo(290)
        }
        
        reportDescriptionView.snp.makeConstraints {
            $0.top.equalTo(reportGraphView.snp.bottom)
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
        toolbar.backgroundColor = Asset.Colors.white.color
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

extension ReportGraphViewController: ReportTopViewDelegate {
    func touchupMonthButton() {
        
    }
}

// MARK: - ReportGraphView Delegate

extension ReportGraphViewController: ReportGraphViewDelegate {
    func touchupThreeMonthButton() {
        reportGraphView.threeMonthSelected = true
        reportGraphView.fiveMonthSelected = false
    }
    
    func touchupFiveMonthButton() {
        reportGraphView.threeMonthSelected = false
        reportGraphView.fiveMonthSelected = true
    }
}