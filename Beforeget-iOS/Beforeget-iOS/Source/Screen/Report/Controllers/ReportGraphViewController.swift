//
//  ReportGraphViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit

final class ReportGraphViewController: UIViewController {
    
    // MARK: - Network
    
    private let reportAPI = ReportAPI.shared
    
    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    var reportGraphView = ReportGraphView()
    var reportDescriptionView = ReportDescriptionView()
    private lazy var monthPicker = MonthYearPickerView()
    
    private var months = [String]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        reportTopView.reportTitle = "월별 그래프"
        reportTopView.reportDescription = "가장 많은 기록을 한 달을 확인해보세요"
        
        reportGraphView.delegate = self
        reportGraphView.threeMonthSelected = false
        reportGraphView.fiveMonthSelected = true
        
        reportGraphView.month = addOrSubtractMonth(month: -1)
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportGraphView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 126 : 115)
            $0.height.equalTo(UIScreen.main.hasNotch ? 70 : 66)
        }
        
        reportGraphView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.height.equalTo(UIScreen.main.hasNotch ? 290 : 242)
        }
        
        reportDescriptionView.snp.makeConstraints {
            $0.top.equalTo(reportGraphView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(157)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        reportGraphView.barView1.barTitle = addOrSubtractMonth(month: -5)
        reportGraphView.barView2.barTitle = addOrSubtractMonth(month: -4)
        reportGraphView.barView3.barTitle = addOrSubtractMonth(month: -3)
        reportGraphView.barView4.barTitle = addOrSubtractMonth(month: -2)
        reportGraphView.barView5.barTitle = addOrSubtractMonth(month: -1)
    }
    
    private func addOrSubtractMonth(month:Int) -> String {
        guard let date = Calendar.current.date(byAdding: .month, value: month, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월"
        return dateFormatter.string(from: date)
    }
    
    private func setBarTitle(monts: [String]) {
        reportGraphView.barView1.barTitle = monts[0]
        reportGraphView.barView2.barTitle = monts[1]
        reportGraphView.barView3.barTitle = monts[2]
        reportGraphView.barView4.barTitle = monts[3]
        reportGraphView.barView5.barTitle = monts[4]
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
