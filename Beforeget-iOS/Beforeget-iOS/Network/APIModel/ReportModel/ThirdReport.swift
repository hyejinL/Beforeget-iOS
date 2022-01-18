//
//  ThirdReportResponse.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/19.
//

import Foundation

struct ThirdReport: Codable {
    let start: String
    let arr: [Arr]
    let title, label: String
}

struct Arr: Codable {
    let type: String
    let count: Int
}
