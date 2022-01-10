//
//  UIViewController+.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

extension UIViewController {
    func setupStatusBar(_ color: UIColor) {
        let margin = view.layoutMarginsGuide
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        statusbarView.frame = CGRect.zero
        view.addSubview(statusbarView)
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
        ])
    }
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
