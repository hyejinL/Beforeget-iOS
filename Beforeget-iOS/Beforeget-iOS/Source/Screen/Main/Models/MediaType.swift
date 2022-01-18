//
//  MediaType.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/12.
//

enum MediaType: Int, CustomStringConvertible, CaseIterable {
    case movie
    case book
    case tv
    case music
    case webtoon
    case youtube
    
    static let count: Int = MediaType.allCases.count
    
    var description: String {
        switch self {
        case .movie: return "Movie"
        case .book: return "Book"
        case .tv: return "TV"
        case .music: return "Music"
        case .webtoon: return "Webtoon"
        case .youtube: return "Youtube"
        }
    }
    
    func recordCount(_ media: Main?) -> Int {
        guard let media = media else { return Int() }
        switch self {
        case .movie: return media.movie
        case .book: return media.book
        case .tv: return media.tv
        case .music: return media.music
        case .webtoon: return media.webtoon
        case .youtube: return media.youtube
        }
    }
}
