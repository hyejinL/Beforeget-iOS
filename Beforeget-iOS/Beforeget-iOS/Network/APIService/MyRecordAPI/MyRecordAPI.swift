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
    
    public var detailDate: String = "-1"
    public var detailMedia: String = "-1"
    public var detailStar: String = "-1"
    public var detailId: Int = 0
    public var detailComment: String = ""
    public var detailOneline: [String] = [""]
    
    public private(set) var detailIds: [Int] = []
    public private(set) var detailTitles:  [String] = []
    public private(set) var detailCategories: [Int] = []
    public private(set) var detailDates: [String] = []
    public private(set) var detailStars:  [Int] = []
    public private(set) var detailOnelines:  [String] = []
    public private(set) var detailComments: [String] = []
    
    // MARK: - Network Properties
    
    private let myRecordProvider = MoyaProvider<MyRecordService>(plugins: [MoyaLoggerPlugin()])
    
    public private(set) var myRecord: BaseArrayResponseType<MyRecord>?
    public private(set) var myDetailRecord: BaseArrayResponseType<MyDetailRecord>?

    public private(set) var dates: [String] = []
    public private(set) var stars:  [Int] = []
    public private(set) var titles:  [String] = []
    public private(set) var onelines:  [String] = []
    
    // MARK: - Custom Method
    
    func removeAllData() {
        dates.removeAll()
        stars.removeAll()
        titles.removeAll()
        onelines.removeAll()
    }
    
    func removeDetailData() {
        detailDates.removeAll()
        detailTitles.removeAll()
        detailCategories.removeAll()
        detailStars.removeAll()
        detailOnelines.removeAll()
        detailComments.removeAll()
    }
    
    // MARK: - GET : 전체글조회 가져오기
    
    func getMyRecord(completion: @escaping (([MyRecord]?, Error?) -> ())) {
        myRecordProvider.request(.myRecord) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.myRecord = try result.map(BaseArrayResponseType<MyRecord>.self)
                    self.removeAllData()
                    guard let data = self.myRecord?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    if !data.isEmpty {
                        for i in 0..<data.count {
                            self.dates.append(data[i].date)
                            self.stars.append(data[i].star)
                            self.titles.append(data[i].title)
                            self.onelines.append(data[i].oneline)
                        }
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
    
    func getMyRecordFilter(date: String, media: String, star: String, completion: @escaping (([MyRecord]?, Error?) -> ())) {
        myRecordProvider.request(MyRecordService.filter(date: date, media: media, star: star)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.myRecord = try result.map(BaseArrayResponseType<MyRecord>.self)
                    guard let data = self.myRecord?.data else {
                        completion(nil, NetworkResult<Error>.self as? Error)
                        return
                    }
                    
                    print(data, "에러메시지 : getMyRecordFilter")
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
                    self.removeDetailData()
                    guard let data = self.myDetailRecord?.data else {
                        completion(nil, NetworkResult<Error>.self as? Error)
                        return
                    }
                    
                    if !data.isEmpty {
                        for i in 0..<data.count {
                            self.detailDates.append(data[i].date)
                            self.detailStars.append(data[i].star)
                            self.detailTitles.append(data[i].title)
                            self.detailOnelines = data[i].oneline
                            self.detailCategories.append(data[i].category)
                            self.detailComments.append(data[i].comment)
                        }
                    }
                    
                    print(data, "에러메시지 : getMyDetailRecord")
                     completion(data, nil)
                    
                } catch(let err) {
                    print(err.localizedDescription, "에러메시지 : MyDetailRecord")
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription, "에러메시지 : getMyDetailRecord")
                completion(nil, err)
            }
        }
    }
}
