//
//  SecondReportResponse.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/19.
//

import Foundation

struct SecondReport: Codable {
    let start: String
    let recordCount: [RecordCount]
    let comment: String
}

struct RecordCount: Codable {
    let count, month: Int
}
