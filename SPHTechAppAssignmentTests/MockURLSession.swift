//
//  MockURLSession.swift
//  SPHTechAppAssignment
//
//  Created by apple on 2021/5/22.
//

import UIKit

class MockURLSession: URLSessionProtocol {
    
    var mockDataTask = MockURLSessionDataTask()
    var mockData: Data?
    var mockError: Error?
    
    func constructionHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(mockData, constructionHttpURLResponse(request: request), mockError)
        return mockDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {
    }
}
