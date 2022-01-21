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
    let comment: String
    let additional: [DetailAdditional]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? 0
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
        category = (try? values.decode(Int.self, forKey: .category)) ?? 0
        date = (try? values.decode(String.self, forKey: .date)) ?? ""
        star = (try? values.decode(Int.self, forKey: .star)) ?? 0
        oneline = (try? values.decode([String].self, forKey: .oneline)) ?? [""]
        comment = (try? values.decode(String.self, forKey: .comment)) ?? ""
        additional = (try? values.decode([DetailAdditional].self, forKey: .additional)) ?? []
    }

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title, category, date, star, oneline, comment, additional
    }
}

// MARK: - DetailAdditional

struct DetailAdditional: Codable {
    let type: String
    let imgUrl1: String
    let content: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = (try? values.decode(String.self, forKey: .type)) ?? ""
        imgUrl1 = (try? values.decode(String.self, forKey: .imgUrl1)) ?? ""
        content = (try? values.decode(String.self, forKey: .content)) ?? ""
    }
}
