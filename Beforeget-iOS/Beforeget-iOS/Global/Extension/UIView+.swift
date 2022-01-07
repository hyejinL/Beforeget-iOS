//
//  UIView+.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

extension UIView {
    func makeShadow(_ color: UIColor,
                    _ opacity: Float,
                    _ offset: CGSize,
                    _ radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    public func addSubviews(_ view: [UIView]) {
        view.forEach { self.addSubview($0) }
    }
    
    /// 각 TVC,CVC의 className을 String으로 가져올 수 있도록 연산 프로퍼티를 설정합니다. 이 값들은 나중에 Identifier에 잘 써먹을 수 있습니다  (by. 송지훈 - 28기 iOS 파트장님)
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
