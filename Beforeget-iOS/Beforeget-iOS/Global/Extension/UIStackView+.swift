//
//  UIStackView+.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ view: [UIView]) {
        view.forEach{ self.addArrangedSubview($0) }
    }
}
