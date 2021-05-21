//
//  ApiCacheUtil.swift
//  SPHTechAppAssignment
//
//  Created by zhulei on 2021/5/21.
//

import UIKit


class ApiCacheUtil {
    
    let saveURL: URL
    
    init(saveURL: URL) {
        self.saveURL = saveURL
    }
    
    func save<T: Codable>(object: T) {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(object)
            try encoded.write(to: self.saveURL)
        } catch {
            print("cache failed")
        }
    }
    
    func fetch<T: Codable>() -> T? {
        guard let data = try? Data(contentsOf: self.saveURL) else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let cache = try decoder.decode(T.self, from: data)
            return cache
        } catch {
            return nil
        }
    }
}
