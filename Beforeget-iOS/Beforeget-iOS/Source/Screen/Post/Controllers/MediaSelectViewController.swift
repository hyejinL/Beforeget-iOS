//
//  MediaSelectViewController.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/10.
//

import UIKit
import Then
import SnapKit

class MediaSelectViewController: UIViewController {

    // MARK: - Properties
    
    private let topBarView = UIView().then {
        $0.backgroundColor = Asset.Colors.white.color
    }
    
    private lazy var closeButton = CloseButton(root: self)
    
    private let messageLabel = UILabel().then {
        $0.text = "오늘은 어떤 미디어를\n감상하셨나요?"
        $0.font = BDSFont.title2
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([topBarView,
                          closeButton,
                          messageLabel])
        
        topBarView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.top).inset(6)
            $0.trailing.equalTo(topBarView.snp.trailing).inset(7)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(topBarView.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    // MARK: - Custom Method

}
