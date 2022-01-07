//
//  UITextField+.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

extension UITextField {
    func addLeftPadding(width: CGFloat = 14) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addRightPadding(width: CGFloat = 14) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
