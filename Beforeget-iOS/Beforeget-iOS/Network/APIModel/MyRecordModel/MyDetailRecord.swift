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
    let comment: JSONNull?
    let additional: [Additional]

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
    let imgUrl2: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }
    
    func hash(into hasher: inout Hasher) {
         
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
