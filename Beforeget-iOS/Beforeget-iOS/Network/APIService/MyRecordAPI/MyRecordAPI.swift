//
//  MyRecordAPI.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/19.
//

import Foundation

import Moya

final class MyRecordAPI {
    
    // MARK: - Static Properties
    
    static let shared: MyRecordAPI = MyRecordAPI()
    private init() { }
    
    // MARK: - Network Properties
    
    private let myRecordProvider = MoyaProvider<MyRecordService>(plugins: [MoyaLoggerPlugin()])
    public private(set) var myRecord: BaseArrayResponseType<MyRecord>?
    
    // MARK: - GET
    
    func getMain(completion: @escaping (([MyRecord]?, Error?) -> ())) {
        myRecordProvider.request(.myRecord) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.myRecord = try result.map(BaseArrayResponseType<MyRecord>.self)
                    guard let data = self.myRecord?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
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
