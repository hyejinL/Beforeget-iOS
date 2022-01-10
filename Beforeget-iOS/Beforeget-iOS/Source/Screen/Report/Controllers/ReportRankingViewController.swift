//
//  ReportRankingViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

class ReportRankingViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var reportTopView = ReportTopView()
    private lazy var reportRankingView = ReportRankingView()
    private lazy var reportDescriptionView = ReportDescriptionView()
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
        
        reportTopView.monthButton.inputAccessoryView = createToolbar()
        reportTopView.monthButton.inputView = monthPicker
        
        reportTopView.reportTitle = "유형별 랭킹"
        reportTopView.reportDescription = "12월 한 달 기록률이 가장 높은 top 3"
        
        reportDescriptionView.descriptionTitle = "책을 가장 많이 읽었어요"
        reportDescriptionView.descriptionContent = """
                                                12월 한 달간 22권의 책을 기록하셨네요!
                                                다음으로 많은 기록을 남긴 유형 음악과 영화는
                                                각각 10개, 7개 기록했어요.
                                                """
        
        reportRankingView.firstCount = 22
        reportRankingView.firstType = "Book"
        reportRankingView.secondCount = 10
        reportRankingView.secondType = "Music"
        reportRankingView.thirdCount = 7
        reportRankingView.thirdType = "Movie"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportRankingView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(146)
        }
        
        reportRankingView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.height.equalTo(290)
        }
        
        reportDescriptionView.snp.makeConstraints {
            $0.top.equalTo(reportRankingView.snp.bottom)
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
        view.endEditing(true)
    }
}

// MARK: - ReportTopView Delegate

extension ReportRankingViewController: ReportTopViewDelegate {
    func touchUpMonthButton() {
        reportTopView.monthButton.responder = true
        reportTopView.monthButton.becomeFirstResponder()
    }
}
