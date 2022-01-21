//
//  ReportRankingViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

import Kingfisher

final class ReportRankingViewController: UIViewController {
    
    // MARK: - Network
    
    private let reportAPI = ReportAPI.shared
    
    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    var reportRankingView = ReportRankingView()
    var reportDescriptionView = ReportDescriptionView()
    private lazy var monthPicker = MonthYearPickerView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        reportTopView.monthButton.inputAccessoryView = setupToolbar()
        reportTopView.monthButton.inputView = monthPicker
        
        reportTopView.reportTitle = "유형별 랭킹"
        reportTopView.reportDescription = "\(addOrSubtractMonth(month: -1)) 한 달 기록률이 가장 높은 top 3"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportRankingView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            $0.height.equalTo(UIScreen.main.hasNotch ? 146 : 142)
        }
        
        reportRankingView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.height.equalTo(UIScreen.main.hasNotch ? 290 : 242)
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
    }
    
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
    
    private func addOrSubtractMonth(month:Int) -> String {
        guard let date = Calendar.current.date(byAdding: .month, value: month, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - @objc

    @objc func touchupDoneButton() {
        reportTopView.monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        view.endEditing(true)
        
        // MARK: - TODO: 01~09월의 데이터 통신 
        
        reportAPI.getThirdReport(date: "\(monthPicker.year)-\(monthPicker.month)") { [weak self] data, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            self.reportTopView.reportDescription = "\(self.monthPicker.month)월 한 달 기록률이 가장 높은 top3"
            
            self.reportRankingView.firstType = data.arr[0].type
            self.reportRankingView.firstCount = data.arr[0].count
            self.reportRankingView.secondType = data.arr[1].type
            self.reportRankingView.secondCount = data.arr[1].count
            self.reportRankingView.thirdType = data.arr[2].type
            self.reportRankingView.thirdCount = data.arr[2].count
            
            self.reportDescriptionView.descriptionTitle = data.title
            self.reportDescriptionView.descriptionContent = data.label
        }
    }
}

// MARK: - ReportTopView Delegate

extension ReportRankingViewController: ReportTopViewDelegate {
    func touchupMonthButton() { }
}

