//
//  GraphService.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/19.
//

import Foundation

import Moya

enum ReportService {
    case first(date: String)
    case second(date: String, count: Int)
    case third(date: String)
    case fourth(date: String)
    case total(date: String, count: Int)
}

extension ReportService: TargetType {
    
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .first(let date):
            return "/statistic/first/\(date)"
        case .second(let date, let count):
            return "/statistic/second/\(date)/\(count)"
        case .third(let date):
            return "/statistic/third/\(date)"
        case .fourth(let date):
            return "/statistic/fourth/\(date)"
        case .total(let date, let count):
            return "/statistic/total/\(date)/\(count)"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .first, .second, .third, .fourth, .total:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .first, .second, .third, .fourth, .total:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .first, .second, .third, .fourth, .total:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .first, .second, .third, .fourth, .total:
            return Token.accessToken
        }
    }
}

