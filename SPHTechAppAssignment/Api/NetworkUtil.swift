//
//  NetworkUtil.swift
//  SwiftDemo
//
//  Created by apple on 2021/5/16.
//

import UIKit

//custom network request error
struct NetworkError: Error {
    var message: String?
    init(_ message: String) {
        self.message = message
    }
}

//A simple network tool that encapsulates GET requests
class NetworkUtil: NSObject {
    
    func get(url: String,
             params: [String:Any]!,
             success: @escaping (Any) -> Void,
             failure: @escaping (NetworkError) -> Void) -> Void {
        //Stitching parameters
        var i = 0
        var address = url
        if let paras = params {
            for (key, value) in paras {
                if i == 0 {
                    address += "?\(key)=\(value)"
                } else {
                    address += "&\(key)=\(value)"
                }
                i += 1
            }
        }
        
        let finalUrl = URL(string: address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession.shared
        
        var request = URLRequest(url: finalUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 12)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let theError = error {
                failure(NetworkError(theError.localizedDescription))
            } else {
                if let theData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: theData, options: [])
                        DispatchQueue.main.async {
                            success(json)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            failure(NetworkError("JSON serialization error"))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        failure(NetworkError("empty data"))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
