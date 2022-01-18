//
//  MainAPI.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/18.
//

import Foundation
import Moya

public class MainAPI {

    static let shared = MainAPI()
    var mainProvider = MoyaProvider<MainService>(plugins: [MoyaLoggerPlugin()])

    public init() { }

    func getMainData(completion: @escaping (NetworkResult<Any>) -> Void) {
        mainProvider.request(.main) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeMainDatasStatus(by: statusCode, data)
                completion(networkResult)

            case .failure(let err):
                print(err)
            }
        }
    }

    private func judgeMainDatasStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<MainResponse>.self, from: data)
        else {
            return .pathErr
        }

        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "디코드 오류")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data)
        else { return .pathErr }

        switch statusCode {
        case 200:
            return .success(decodedData.message)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
