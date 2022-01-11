//
//  Filter.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/12.
//

import Foundation

enum Section {
    case main
}

struct Filter: Hashable {
    let filterMenu: String
    
    init(filterMenu: String) {
        self.filterMenu = filterMenu
    }
}

extension Filter {
    static let dateMenu = [Filter(filterMenu: "2주"),
                           Filter(filterMenu: "1개월"),
                           Filter(filterMenu: "3개월"),
                           Filter(filterMenu: "직접입력")]
    
    static let mediaMenu = [Filter(filterMenu: "Movie"),
                            Filter(filterMenu: "Book"),
                            Filter(filterMenu: "Music"),
                            Filter(filterMenu: "Youtube"),
                            Filter(filterMenu: "Webtoon"),
                            Filter(filterMenu: "TV")]
    
    static let starMenu = [Filter(filterMenu: "1"),
                           Filter(filterMenu: "2"),
                           Filter(filterMenu: "3"),
                           Filter(filterMenu: "4"),
                           Filter(filterMenu: "5")]
}
