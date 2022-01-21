//
//  WritingRequiredFieldPopupView.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/21.
//

import UIKit

import SnapKit
import Then

final class WritingRequiredFieldPopupView: UIView {
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
    
    private var popupView = BDSPopupView(
        image: Asset.Assets.imgSave.image,
        title: PopupText.requiredField,
        info: .none).then {
            $0.leftButton.isHidden = true
            $0.rightText = "확인"
            $0.rightButton.addTarget(self, action: #selector(touchupRightButton(_:)), for: .touchUpInside)
        }
    
    // MARK: - Initializer
    
    init(viewController: UIViewController) {
        super.init(frame: .zero)
        self.viewController = viewController
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func configUI() {
        backgroundColor = Asset.Colors.white.color
        layer.cornerRadius = 10
    }
    
    private func setupLayout() {
        addSubview(popupView)
        
        popupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupRightButton(_ sender: UIButton) {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
