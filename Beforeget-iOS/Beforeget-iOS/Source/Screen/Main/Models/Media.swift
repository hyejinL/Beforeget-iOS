//
//  Media.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/09.
//

import Foundation

struct Media: Codable {
    let book, music, movie, tv: Int
    let youtube, webtoon: Int

    enum CodingKeys: String, CodingKey {
        case book = "Book"
        case music = "Music"
        case movie = "Movie"
        case tv = "TV"
        case youtube = "Youtube"
        case webtoon = "Webtoon"
    }
}
