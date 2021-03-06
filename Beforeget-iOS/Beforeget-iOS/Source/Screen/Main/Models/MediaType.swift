//
//  MediaType.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/12.
//

import UIKit

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
        guard let media = media else { return 0 }
        switch self {
        case .movie: return media.movie
        case .book: return media.book
        case .tv: return media.tv
        case .music: return media.music
        case .webtoon: return media.webtoon
        case .youtube: return media.youtube
        }
    }
    
    func mediaNumber() -> Int {
        switch self {
        case .movie: return 1
        case .book: return 2
        case .tv: return 3
        case .music: return 4
        case .webtoon: return 5
        case .youtube: return 6
        }
    }
    
    func getIconImage(index: Int) -> UIImage? {
        switch self {
        case .movie:
            return Asset.Assets.icnWriteMovie.image
        case .book:
            return Asset.Assets.icnWriteBook.image
        case .tv:
            return Asset.Assets.icnWriteTv.image
        case .music:
            return Asset.Assets.icnWriteMusic.image
        case .webtoon:
            return Asset.Assets.icnWebtoon.image
        case .youtube:
            return Asset.Assets.icnWriteYoutube.image
        }
    }
    
    static func getIconImage(index: Int) -> UIImage? {
        switch index {
        case 1: return Asset.Assets.icnWriteMovie.image
        case 2: return Asset.Assets.icnWriteBook.image
        case 3: return Asset.Assets.icnWriteTv.image
        case 4: return Asset.Assets.icnWriteMusic.image
        case 5: return Asset.Assets.icnWriteWebtoon.image
        default: return Asset.Assets.icnWriteYoutube.image
        }
    }
}
