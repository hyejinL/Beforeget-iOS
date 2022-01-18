//
//  FourthResponse.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/19.
//

import Foundation

struct FourthReport: Codable {
    let start: String
    let oneline: Oneline
}

struct Oneline: Codable {
    let movie, book, tv, music: [String]
    let webtoon, youtube: [String]

    enum CodingKeys: String, CodingKey {
        case movie = "Movie"
        case book = "Book"
        case tv = "TV"
        case music = "Music"
        case webtoon = "Webtoon"
        case youtube = "Youtube"
    }
}
