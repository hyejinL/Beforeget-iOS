//
//  BaseResponse.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/18.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int
    let success: Bool
    let message: String
    let data: T
}
