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
    
    var reportOnePageView = ReportOnePageView()
    private var monthPicker = MonthYearPickerView()
    
    var sentence: [String] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        view.addSubviews([reportOnePageView])
        
        reportOnePageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 126 : 115)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 54 : 65)
        }
    }
}
