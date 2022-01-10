//
//  PostModel.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import Foundation

// MARK: - PostModel

struct PostModel: Codable {
    let post: [Post]
}

// MARK: - Post

struct Post: Codable {
    let id: Int
    let title: String
    let category: Int
    let date: String
    let star: Int
    let oneline: String
}
