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
            return ["Content-Type": "application/json",
                    "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJzdWJpbjA3MjNAYmVmb3JlZ2V0LmNvbSIsIm5pY2siOiLtj6zrppAiLCJpZEZpcmViYXNlIjoiaXNRM1kzVU4xSVlqdmQzMXpsZk5Bd2FHejFtMSIsImlhdCI6MTY0MjQzNTEzMSwiZXhwIjoxNjQzNjQ0NzMxLCJpc3MiOiJjaGFud29vIn0.zIK0c8Gq1f_GcJ_UjkwABWfXQ5UbVSU5M69uEqZhKkc"]

        }
    }
}


