//
//  Media.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/09.
//

import Foundation

struct Media: Codable {
    let movie, book, tv, music: Int
    let webtoon, youtube: Int

    enum CodingKeys: String, CodingKey {
        case movie = "Movie"
        case book = "Book"
        case tv = "TV"
        case music = "Music"
        case webtoon = "Webtoon"
        case youtube = "Youtube"
    }
}
