//
//  NetworkUtil.swift
//  SwiftDemo
//
//  Created by apple on 2021/5/16.
//

import UIKit

class NetworkUtil: NSObject {
    
    
    func get(url: String,
             params: [String:String]!,
             success: @escaping (AnyObject) -> Void,
             failure: @escaping (Error) -> Void) -> Void {
        
        
        var items = [URLQueryItem]()
        
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        let urlComp = NSURLComponents(string: url)!
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if (error != nil) {
                failure(error!);
            } else {
                if (data != nil) {
                    
                    do {
                        let jsonObj =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject
                        success(jsonObj as AnyObject);
                    } catch {
                        print(error)
                    }
                    
                } else {
                    //
                    
                    
                }
            }
        })
        task.resume()
    }
    
}
