//
//  MyRecordFilter.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/19.
//

import Foundation

// MARK: - MyRecordFilter

struct MyRecordFilter: Codable {
    let id, userID, category: Int
    let date: String
    let star: Int
    let title, oneline: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case category, date, star, title, oneline
    }
}
