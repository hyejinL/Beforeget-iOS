//
//  PostService.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/19.
//

import Foundation

import Moya

enum PostService {
    case oneLine(mediaId: Int)
    case item(mediaId: Int)
    case post(param: PostRequest) // (param: 바디 request 데이터 모델) // Request 모델 생성해주기
}

extension PostService: TargetType {
     
    var baseURL: URL {
        return URL(string: NetworkConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .oneLine(let mediaId):
            return "/category/\(mediaId)"
        case .item(let mediaId):
            return "/category/\(mediaId)/additional"
        case .post:
            return "/post/upload"
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .oneLine, .item, .post:
            return JSONEncoding.default
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oneLine, .item:
            return .get
        case .post:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .oneLine:
            return .requestPlain
        case .item:
            return .requestPlain
        case .post(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .oneLine:
            return Token.accessToken
        case .item:
            return Token.accessToken
        case .post:
            return Token.accessToken
        }
    }
}
