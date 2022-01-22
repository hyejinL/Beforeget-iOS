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
    
    // MARK: - Network
    
    private var reportAPI = ReportAPI.shared
    
    // MARK: - Properties
    
    var reportTopView = ReportTopView()
    var typeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    var reportDescriptionView = ReportDescriptionView()
    private var monthPicker = MonthYearPickerView()
    
    var descriptionTitle: String?
    var descriptionContent: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        reportTopView.reportTitle = "\(addOrSubtractMonth(month: -1))의 밴토리님은?"
        reportTopView.reportDescription = "이번 달 나의 소비 유형을 알아보세요"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, typeImageView, reportDescriptionView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 126 : 115)
            $0.height.equalTo(UIScreen.main.hasNotch ? 70 : 66)
        }
        
        typeImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.height.equalTo(UIScreen.main.hasNotch ? 290 : 242)
        }
        
        reportDescriptionView.snp.makeConstraints {
            $0.top.equalTo(typeImageView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 87 : 62)
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
