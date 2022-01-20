//
//  Date+.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/16.
//

import Foundation

extension Date {
    func convertToString(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
}
