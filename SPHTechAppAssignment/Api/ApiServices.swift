//
//  ApiServices.swift
//  SwiftDemo
//
//  Created by zhulei on 2021/5/17.
//

import UIKit

//Handle result data and cache
class ApiServices: NSObject {
    
    let networkUtil: NetworkUtil = NetworkUtil()
    let cacheUtil: ApiCacheUtil!
    
    override init() {
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.cacheUtil = ApiCacheUtil(saveURL: cacheDir.appendingPathComponent("MobileDataUsage"))
    }
    
    func fetchMobileDataUsage(success: @escaping([QuarterlyMobileDataUsage]) -> Void, failure: @escaping(NetworkError) -> Void) {
        
        let parDic: [String : String] = ["resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "limit": "50"]
        
        networkUtil.get(url: "https://data.gov.sg/api/action/datastore_search", params: parDic) { (respond: URLResponse?, result: Any?) in
            var array = [QuarterlyMobileDataUsage]();
            let data = result as! [String: AnyObject]
            let resultDic = data["result"] as! [String: AnyObject]
            let records = resultDic["records"] as! [[String: AnyObject]]
            for data in records {
                let model : QuarterlyMobileDataUsage = QuarterlyMobileDataUsage();
                model.id = data["_id"] as? Int
                model.quarter = data["quarter"] as? String
                model.volumeOfMobileData = data["volume_of_mobile_data"] as? String
                array.append(model)
            }
            self.cacheUtil .save(object: array);
            success(array)
        } failure: { (error: NetworkError) in
            if let array: [QuarterlyMobileDataUsage] = self.cacheUtil .fetch() {
                success(array)
            } else {
                failure(error);
            }
        }
    }
    
}
