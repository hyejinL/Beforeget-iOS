//
//  ReportLoadingView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/20.
//

import UIKit

import SnapKit
import Then

import Lottie

class ReportLoadingView: UIView {
    
    // MARK: - Properties
    
    private var loadingLottieAnimationView = AnimationView(name: "threeWhiteLine")

    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = Asset.Colors.black200.color.withAlphaComponent(0.7)
    }
    
    private func setupLayout() {
        self.addSubview(loadingLottieAnimationView)
        
        loadingLottieAnimationView.snp.makeConstraints {
            $0.width.height.equalTo(250)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    public func play() {
        loadingLottieAnimationView.play()
        loadingLottieAnimationView.loopMode = .loop
    }
    
    public func stop() {
        loadingLottieAnimationView.stop()
        loadingLottieAnimationView.removeFromSuperview()
    }
}
