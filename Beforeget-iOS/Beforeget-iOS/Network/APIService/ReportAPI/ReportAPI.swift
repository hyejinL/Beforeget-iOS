//
//  GraphAPI.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/19.
//

import Foundation

import Moya

final class ReportAPI {
    
    // MARK: - Static Properties
    
    static let shared: ReportAPI = ReportAPI()
    private init() { }
    
    // MARK: - Network Properties
    
    private let reportProvider = MoyaProvider<ReportService>(plugins: [MoyaLoggerPlugin()])
    
    public private(set) var firstReportResponse: BaseResponse<FirstReport>?
    public private(set) var firstReportData: FirstReport?
    
    public private(set) var secondReportResponse: BaseResponse<SecondReport>?
    public private(set) var secondReportData: SecondReport?
    
    public private(set) var thirdReportResponse: BaseResponse<ThirdReport>?
    public private(set) var thirdReportData: ThirdReport?
    
    public private(set) var fourthReportResponse: BaseResponse<FourthReport>?
    public private(set) var fourthReportData: FourthReport?
    
    public private(set) var totalReportResponse: BaseResponse<TotalReport>?
    public private(set) var totalReportData: TotalReport?
    
    // MARK: - GET First
    
    func getFirstReport(date: String, completion: @escaping ((FirstReport?, Error?) -> ())) {
        reportProvider.request(.first(date: date)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.firstReportResponse = try result.map(BaseResponse<FirstReport>.self)
                    guard let data = self.firstReportResponse?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    self.firstReportData = data
                    
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
    
    // MARK: - GET Second
    
    func getSecondReport(date: String, count: Int, completion: @escaping ((SecondReport?, Error?) -> ())) {
        reportProvider.request(.second(date: date, count: count)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.secondReportResponse = try result.map(BaseResponse<SecondReport>.self)
                    guard let data = self.secondReportResponse?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    self.secondReportData = data
                    
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
    
    // MARK: - GET Third
    
    func getThirdReport(date: String, completion: @escaping ((ThirdReport?, Error?) -> ())) {
        reportProvider.request(.third(date: date)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.thirdReportResponse = try result.map(BaseResponse<ThirdReport>.self)
                    guard let data = self.thirdReportResponse?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    self.thirdReportData = data
                    
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
    
    // MARK: - GET Fourth
    
    func getFourth(date: String, completion: @escaping ((FourthReport?, Error?) -> ())) {
        reportProvider.request(.fourth(date: date)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.fourthReportResponse = try result.map(BaseResponse<FourthReport>.self)
                    guard let data = self.fourthReportResponse?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    self.fourthReportData = data
                    
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
    
    // MARK: - GET Total
    
    func getTotal(date: String, count: Int, completion: @escaping ((TotalReport?, Error?) -> ())) {
        reportProvider.request(.total(date: date, count: count)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                do {
                    self.totalReportResponse = try result.map(BaseResponse<TotalReport>.self)
                    guard let data = self.totalReportResponse?.data else {
                        completion(nil, Error.self as? Error)
                        return
                    }
                    self.totalReportData = data
                    
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

