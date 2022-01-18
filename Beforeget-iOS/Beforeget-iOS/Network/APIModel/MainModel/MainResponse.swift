//
//  MainResponse.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/18.
//

import Foundation

struct Main: Codable {
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
