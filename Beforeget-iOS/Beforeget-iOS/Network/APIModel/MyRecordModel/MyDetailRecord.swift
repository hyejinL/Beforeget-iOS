//
//  MyDetailRecord.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/19.
//

import Foundation

// MARK: - MyDetailRecord

struct MyDetailRecord: Codable {
    let id, userID: Int
    let title: String
    let category: Int
    let date: String
    let star: Int
    let oneline: [String]
    let comment: String?
    let additional: [Additional]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title, category, date, star, oneline, comment, additional
    }
}

// MARK: - Additional

struct Additional: Codable {
    let type: String
    let imgUrl1: String?
    let content: String?
}
