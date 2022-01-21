//
//  MainService.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/18.
//

import Foundation

import Moya

enum MainService {
    case main
}

extension MainService: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .main:
            return "/home"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .main:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .main:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .main:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .main:
            return Token.accessToken
        }
    }
}
