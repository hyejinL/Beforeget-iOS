//
//  BackButton.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/09.
//

import UIKit

import SnapKit

final class BackButton: UIButton {
                
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    convenience init(root: UIViewController) {
        self.init()
        setupAction(vc: root)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        setImage(Asset.Assets.btnBack.image, for: .normal)
    }
    
    private func setupLayout() {
        self.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }
    
    // MARK: - Custom Method
    
    private func setupAction(vc: UIViewController) {
        let backAction = UIAction { action in
            vc.navigationController?.popViewController(animated: true)
        }
        self.addAction(backAction, for: .touchUpInside)
    }
}
