//
//  PostRequiredFieldPopupViewController.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/21.
//

import UIKit

import SnapKit

final class PostRequiredFieldPopupViewController: UIViewController {

    // MARK: - Properties
    
    lazy var popupView = WritingRequiredFieldPopupView(viewController: self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.black200.color.withAlphaComponent(0.5)
    }
    
    private func setupLayout() {
        view.addSubview(popupView)
                
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(290)
            make.height.equalTo(220)
        }
    }
}
