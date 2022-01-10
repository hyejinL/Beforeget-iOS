//
//  UIViewController+.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit

extension UIViewController {
    func setupStatusBar(_ color: UIColor) {
        let margin = view.layoutMarginsGuide
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        statusbarView.frame = CGRect.zero
        view.addSubview(statusbarView)
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        
        statusbarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(margin.snp.top)
            make.width.equalTo(view.snp.width).multipliedBy(1.0)
            make.centerX.equalToSuperview()
        }
    }
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
