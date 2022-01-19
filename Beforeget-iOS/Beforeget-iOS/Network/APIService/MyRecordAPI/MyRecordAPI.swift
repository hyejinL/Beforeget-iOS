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
    
    // MARK: - Properties
    
    public var date: String = "-1"
    public var media: String = "-1"
    public var star: String = "-1"
    
    // MARK: - Network Properties
    
    private let myRecordProvider = MoyaProvider<MyRecordService>(plugins: [MoyaLoggerPlugin()])
    
    public private(set) var myRecord: BaseArrayResponseType<MyRecord>?
    public private(set) var myRecordFilter: BaseArrayResponseType<MyRecordFilter>?
    
    // MARK: - GET : Main 가져오기
    
    func getMyRecord(completion: @escaping (([MyRecord]?, Error?) -> ())) {
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
    
    // MARK: - GET : Main/Filter 가져오기
    
    func getMyRecordFilter(completion: @escaping (([MyRecordFilter]?, Error?) -> ())) {
        myRecordProvider.request(MyRecordService.filter(date: "1", media: "2", star: "5")) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.myRecordFilter = try result.map(BaseArrayResponseType<MyRecordFilter>.self)
                    guard let data = self.myRecordFilter?.data else {
                        print("안녕")
                        completion(nil, NetworkResult<Error>.self as? Error)
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
