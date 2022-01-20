//
//  FifthReport.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/19.
//

import Foundation

struct TotalReport: Codable {
    let start, graphic: String
    let oneline: [String]
    let monthly: [Monthly]
    let media: [TotalMedia]
}

struct TotalMedia: Codable {
    let type: String
    let count: Int
}

struct Monthly: Codable {
    let count, month: Int
}
