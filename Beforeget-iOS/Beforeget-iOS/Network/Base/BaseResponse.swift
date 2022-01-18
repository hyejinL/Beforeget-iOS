//
//  BaseResponse.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/18.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: T
}

struct BaseArrayResponseType<T: Decodable>: Decodable {
    let status: Int
    let success: Bool?
    let message: String?
    let data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case status
        case success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([T].self, forKey: .data)) ?? []
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
    }
}
