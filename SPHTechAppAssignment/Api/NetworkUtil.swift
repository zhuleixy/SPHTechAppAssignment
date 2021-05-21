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
    var request: URLRequest?
    init(_ message: String, _ request: URLRequest) {
        self.message = message
        self.request = request
    }
}

//A simple network tool that encapsulates GET requests
class NetworkUtil: NSObject {
    
    func get(url: String,
             params: [String:Any]!,
             success: @escaping (URLResponse?, Any?) -> Void,
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
        
        var request = URLRequest(url: finalUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 12)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let theError = error {
                DispatchQueue.main.async {
                    failure(NetworkError(theError.localizedDescription, request))
                }
            } else {
                if let theData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: theData, options: [])
                        DispatchQueue.main.async {
                            success(respond, json)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            failure(NetworkError("JSON serialization error", request))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        failure(NetworkError("empty data", request))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
