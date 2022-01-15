//
//  UICollectionView+.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

extension UICollectionView {
    func deselectAllItems(animated: Bool = false) {
        for indexPath in indexPathsForSelectedItems ?? [] {
            deselectItem(at: indexPath, animated: animated)
        }
    }
}
