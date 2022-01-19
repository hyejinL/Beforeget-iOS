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
    public var id: Int = 0
    
    // MARK: - Network Properties
    
    private let myRecordProvider = MoyaProvider<MyRecordService>(plugins: [MoyaLoggerPlugin()])
    
    public private(set) var myRecord: BaseArrayResponseType<MyRecord>?
    public private(set) var myRecordFilter: BaseArrayResponseType<MyRecordFilter>?
    public private(set) var myDetailRecord: BaseArrayResponseType<MyDetailRecord>?
//    public private(set) var additional: Additional?

    
    // MARK: - GET : 전체글조회 가져오기
    
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
                    print(err.localizedDescription, "에러메시지 : getMyRecord")
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription, "에러메시지 : getMyRecord")
                completion(nil, err)
            }
        }
    }
    
    // MARK: - GET : 전체글조회/Filter 가져오기
    
    func getMyRecordFilter(completion: @escaping (([MyRecordFilter]?, Error?) -> ())) {
        myRecordProvider.request(MyRecordService.filter(date: date, media: media, star: star)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.myRecordFilter = try result.map(BaseArrayResponseType<MyRecordFilter>.self)
                    guard let data = self.myRecordFilter?.data else {
                        completion(nil, NetworkResult<Error>.self as? Error)
                       
                        return
                    }
                    completion(data, nil)
                } catch(let err) {
                    print(err.localizedDescription, "에러메시지 : getMyRecordFilter")
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription, "에러메시지 : getMyRecordFilter")
                completion(nil, err)
            }
        }
    }
    
    // MARK: - GET : post/:postId
    
    func getMyDetailRecord(postId: Int, completion: @escaping (([MyDetailRecord]?, Error?) -> ())) {
        myRecordProvider.request(MyRecordService.detailRecord(id: postId)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.myDetailRecord = try result.map(BaseArrayResponseType<MyDetailRecord>.self)
                    guard let data = self.myDetailRecord?.data else {
                        completion(nil, NetworkResult<Error>.self as? Error)
                        return
                    }
                    print(data, "에러메시지 : getMyDetailRecord")
                     completion(data, nil)
                    
                } catch(let err) {
                    print(err.localizedDescription, "에러메시지 : getMyDetailRecord")
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription, "에러메시지 : getMyDetailRecord")
                completion(nil, err)
            }
        }
    }
}
