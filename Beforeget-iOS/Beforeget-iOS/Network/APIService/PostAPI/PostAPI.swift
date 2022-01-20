//
//  PostAPI.swift
//  Beforeget-iOS
//
//  Created by 배은서 on 2022/01/19.
//

import Foundation

import Moya
import Accelerate

final class PostAPI {
    // MARK: - Static Properties
    
    static let shared: PostAPI = PostAPI()
    private init() { }
    
    // MARK: - Network Properties
    
    private let postProvider = MoyaProvider<PostService>(plugins: [MoyaLoggerPlugin()])
    
    public private(set) var oneLineResponse: BaseResponse<OneLine>?
    public private(set) var oneLineData: OneLine?
    
    public private(set) var recommendItemResponse: BaseResponse<RecommendItem>?
    public private(set) var recommendItemData: RecommendItem?
    
    public private(set) var postResponse: BaseResponse<PostResponse>?
    public private(set) var postData: PostResponse?
    
    // MARK: - GET
    
    func getOneLine(mediaId: Int, completion: @escaping ((OneLine?, Error?) -> ())) {
        postProvider.request(.oneLine(mediaId: mediaId)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.oneLineResponse = try result.map(BaseResponse<OneLine>.self)
                    guard let data = self?.oneLineResponse?.data else {
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
    
    func getRecommendItem(mediaId: Int, completion: @escaping ((RecommendItem?, Error?) -> ())) {
        postProvider.request(.item(mediaId: mediaId)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.recommendItemResponse = try result.map(BaseResponse<RecommendItem>.self)
                    guard let data = self?.recommendItemResponse?.data else {
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
    
    func postRecord(record: PostRequest, completion: @escaping ((PostResponse?, Error?) -> ())) {
        let param = record
        postProvider.request(.post(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.postResponse = try result.map(BaseResponse<PostResponse>.self)
                    guard let data = self.postResponse?.data else {
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
