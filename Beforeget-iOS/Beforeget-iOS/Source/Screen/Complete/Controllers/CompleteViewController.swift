//
//  CompleteViewController.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/17.
//

import UIKit

import SnapKit
import Then

final class CompleteViewController: UIViewController {

    // MARK: - Properties
    
    private let completeLabel = UILabel().then {
        $0.text = "새로운 기록이 쌓였어요\n확인해 보세요!"
        $0.font = BDSFont.title2
        $0.textColor = Asset.Colors.black200.color
        $0.numberOfLines = 0
    }
    
    private let completeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = Asset.Assets.imgWriteComplete.image
        $0.backgroundColor = .lightGray
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
        $0.spacing = (UIScreen.main.hasNotch ? 7 : 6)
        $0.addArrangedSubviews([detailRecordButton, mainButton])
    }
    
    private let detailRecordButton = BDSButton().then {
        $0.text = "작성한 글 보러가기"
        $0.addTarget(self, action: #selector(touchupDetailRecordButton(_:)), for: .touchUpInside)
    }
    
    private let mainButton = UIButton().then {
        $0.setTitle("메인으로 돌아가기", for: .normal)
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.setTitleColor(Asset.Colors.gray300.color, for: .highlighted)
        $0.backgroundColor = Asset.Colors.white.color
        $0.titleLabel?.font = BDSFont.title6
        $0.addTarget(self, action: #selector(touchupMainButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
        completeLabel.addLetterSpacing()
        completeLabel.addLineSpacing(spacing: 32)
        completeLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        view.addSubviews([completeLabel,
                          completeImageView,
                          buttonStackView])
        
        completeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 129 : 95)
            make.centerX.equalToSuperview()
        }
        
        completeImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(305)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(completeImageView.snp.bottom).offset(UIScreen.main.hasNotch ? 116 : 49)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(UIScreen.main.hasNotch ? 115 : 114)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupDetailRecordButton(_ sender: UIButton) {
        // MARK: - FIXME 머지 후 수정
        let viewController = DetailRecordViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func touchupMainButton(_ sender: UIButton) {
        let viewController = UINavigationController(rootViewController: MainViewController())
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}
