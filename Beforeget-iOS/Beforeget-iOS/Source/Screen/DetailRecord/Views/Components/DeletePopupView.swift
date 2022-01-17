//
//  DeletePopupView.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class DeletePopupView: UIView {
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
    
    private var popupView = BDSPopupView(
        image: Asset.Assets.imgDelete.image,
        title: PopupText.delete,
        info: .none).then {
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
    
    // MARK: - InitUI
    
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
    
    // MARK: - FIXME 추후에 삭제로 서버통신 넘기기
    @objc func touchupRightButton(_ sender: UIButton) {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
