//
//  MainAPI.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/18.
//

import Foundation

import Moya

final class MainAPI {
    
    // MARK: - Static Properties
    
    static let shared: MainAPI = MainAPI()
    private init() { }
    
    // MARK: - Network Properties
    
    private let mainProvider = MoyaProvider<MainService>(plugins: [MoyaLoggerPlugin()])
    public private(set) var mainResponse: BaseResponse<Main>?
    public private(set) var mainData: Main?
    
    // MARK: - GET
    
    func getMain(completion: @escaping ((Main?, Error?) -> ())) {
        mainProvider.request(.main) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.mainResponse = try result.map(BaseResponse<Main>.self)
                    guard let data = self.mainResponse?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    self.mainData = data
                    completion(data, nil)
                    
                } catch(let err) {
                    print(err.localizedDescription)
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err)
            }
        }
    }
}
