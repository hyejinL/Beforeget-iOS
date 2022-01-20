//
//  LoadingViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/20.
//

import UIKit

import SnapKit
import Then

import Lottie

final class LoadingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var loadingLottieAnimationView = AnimationView(name: "threeWhiteLine").then {
        $0.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        loadingLottieAnimationView.play()
        loadingLottieAnimationView.loopMode = .loop
    }
    
    private func setupLayout() {
        view.addSubview(loadingLottieAnimationView)
        
        loadingLottieAnimationView.snp.makeConstraints {
            $0.width.height.equalTo(250)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}
