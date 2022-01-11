//
//  Record.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/11.
//

import Foundation

// MARK: - Record

struct Record: Codable {
    let id, userID, category: Int
    let date: String
    let star: Int
    let title: String
    let oneline: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case category, date, star, title, oneline
    }
}

struct RecordMannager {
    let record = [Record(id: 1, userID: 1, category: 1, date: "2022-01-08", star: 5, title: "그해 우리는", oneline: ["연수야"]),
                  Record(id: 1, userID: 1, category: 2, date: "2022-03-17", star: 5, title: "그해 우리 두리는", oneline: ["이게맞냑오"]),
                  Record(id: 1, userID: 1, category: 3, date: "2022-10-13", star: 2, title: "그저 그런 사이 아니잖아!!!", oneline: ["흥미딘딘은딘딘"])]
    
    func getCount() -> Int {
        return record.count
    }
    
    func getData(index: Int) -> Record {
        return record[index]
    }
    
    func getStar(index: Int) -> Int {
        return record[index].star
    }
}
