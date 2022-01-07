//
//  UITableViewRegisterable.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

protocol UITableViewRegisterable {
    static func register(target: UITableView)
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static func register(target: UITableView) {
        target.register(Self.self, forCellReuseIdentifier: Self.className)
    }
}
