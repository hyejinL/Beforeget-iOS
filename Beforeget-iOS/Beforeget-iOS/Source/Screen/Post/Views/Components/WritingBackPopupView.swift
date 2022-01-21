//
//  WritingBackPopupView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

import SnapKit

final class WritingBackPopupView: UIView {
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
    
    private var popupView = BDSPopupView(
        image: Asset.Assets.imgBack.image,
        title: PopupText.back,
        info: PopupText.subBack).then {
            $0.leftText = "취소"
            $0.rightText = "확인"
            $0.leftButton.addTarget(self, action: #selector(touchupLeftButton(_:)), for: .touchUpInside)
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
    
    @objc func touchupLeftButton(_ sender: UIButton) {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchupRightButton(_ sender: UIButton) {
        guard let postViewController = viewController?.presentingViewController else { return }
        viewController?.dismiss(animated: true) {
            postViewController.navigationController?.popViewController(animated: true)
        }
    }
}
