//
//  MyRecordService.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/19.
//

import Foundation

import Moya

enum MyRecordService {
    case myRecord
    case filter(date: String, media: String, star: String)
    case detailRecord(id: Int)
}

extension MyRecordService: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .myRecord:
            return "/post"
        case .filter:
            return "/post/filter"
        case .detailRecord(let id):
            return "/post/\(id)"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .myRecord, .filter, .detailRecord :
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .myRecord, .filter, .detailRecord :
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .myRecord, .detailRecord :
            return .requestPlain
        case let .filter(date, media, star):
            return .requestParameters(parameters: ["date": date, "media": media, "star": star], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .myRecord, .filter, .detailRecord :
            return Token.accessToken
        }
    }
}
