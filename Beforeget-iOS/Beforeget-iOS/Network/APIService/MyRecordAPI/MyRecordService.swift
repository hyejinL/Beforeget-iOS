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
}

extension MyRecordService: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .myRecord:
            return "/post"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .myRecord:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .myRecord:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .myRecord:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .myRecord:
            return Token.accessToken
        }
    }
}
