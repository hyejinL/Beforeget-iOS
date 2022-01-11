//
//  Menu.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import Foundation

struct Menu {
    var menu: String
    
    init(menu: String) {
        self.menu = menu
    }
}

struct MenuMannager {
    let menu = [Menu(menu: "기간"),
                Menu(menu: "미디어"),
                Menu(menu: "별점")]
    
    func getMenuText(index: Int) -> String {
        return menu[index].menu
    }
    
    func getMenuCount() -> Int {
        return menu.count
    }
}
