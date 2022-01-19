//
//  PostRequest.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/19.
//

import Foundation

// MARK: - PostRequest
struct PostRequest: Codable {
    let media: Int
    let date: String
    let star: Int
    let title: String
    let oneline: [String]
    let additional: [Additional]
}

// MARK: - Additional
struct Additional: Codable {
    let type, content: String
}
