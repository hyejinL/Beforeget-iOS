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

struct FilterManager {
    let filter = [Filter(filterMenu: "2주"),
                    Filter(filterMenu: "1개월"),
                    Filter(filterMenu: "3개월"),
                    Filter(filterMenu: "직접입력")]
    
    func getFilterText(index: Int) -> String {
        return filter[index].filterMenu
    }
    
    func getFilterCount() -> Int {
        return filter.count
    }
}
