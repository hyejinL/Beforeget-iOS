//
//  UIButton+.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

extension UIButton {
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }
}
