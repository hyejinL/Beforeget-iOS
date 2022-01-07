//
//  UICollectionViewRegisterable.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

protocol UICollectionViewRegisterable {
    static func register(target: UICollectionView)
}

extension UICollectionViewRegisterable where Self: UICollectionViewCell {
    static func register(target: UICollectionView) {
        target.register(Self.self, forCellWithReuseIdentifier: Self.className)
    }
}
