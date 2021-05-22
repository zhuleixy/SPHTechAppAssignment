//
//  NetworkUtil.swift
//  SwiftDemo
//
//  Created by apple on 2021/5/16.
//

import UIKit

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}


//custom network request error
struct NetworkError: Error {
    var message: String?
    var statusCode: Int?
    init(_ message: String, _ statusCode: Int? = 0) {
        self.message = message
        self.statusCode = statusCode
    }
}

//A simple network tool that encapsulates GET requests
class NetworkUtil {

    let session: URLSessionProtocol!
    
    init(_ aSession: URLSessionProtocol? = URLSession.shared) {
        self.session = aSession!
    }
    
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
        
        var request = URLRequest(url: finalUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 12)
        request.httpMethod = "GET"
        
        let dataTask = self.session.dataTask(with: request) { (data, respond, error) in
            if let theError = error {
                DispatchQueue.main.async {
                    failure(NetworkError(theError.localizedDescription, error?._code))
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
                            failure(NetworkError("JSON serialization error", -1001))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        failure(NetworkError("empty data", -1002))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
