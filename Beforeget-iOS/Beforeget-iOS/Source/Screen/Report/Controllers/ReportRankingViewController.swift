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
        reportTopView.reportTitle = "유형별 랭킹"
        reportTopView.reportDescription = "\(addOrSubtractMonth(month: -1)) 한 달 기록률이 가장 높은 top 3"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportRankingView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 126 : 115)
            $0.height.equalTo(UIScreen.main.hasNotch ? 70 : 66)
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
    
    private func addOrSubtractMonth(month:Int) -> String {
        guard let date = Calendar.current.date(byAdding: .month, value: month, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월"
        return dateFormatter.string(from: date)
    }
}

