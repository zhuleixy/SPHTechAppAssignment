//
//  NetworkUtilTests.swift
//  SPHTechAppAssignment
//
//  Created by apple on 2021/5/22.
//

import XCTest

class NetworkUtilTests: XCTestCase {
  
    //test bad url request
    func testRequest_whenBadURL_returnBadURLErrorCode() {
        
        let mockURLSession: MockURLSession = MockURLSession()
        mockURLSession.mockError = NSError(domain: "network", code: NSURLErrorBadURL, userInfo: nil)
    
        let networkUtil: NetworkUtil = NetworkUtil(mockURLSession)
        let expectation = self.expectation(description: "Should return NSURLErrorBadURL error")
        
      
        networkUtil.get(url: "https://www.test.com", params: nil) { (respond: URLResponse?, result: Any?) in
            XCTFail("Should not happen")
        } failure: { (error: NetworkError) in
            XCTAssertEqual(error.statusCode, NSURLErrorBadURL)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //test request timeout
    func testRequest_whenTimeOut_returnTimeOutErrorCode() {
        
        let mockURLSession: MockURLSession = MockURLSession()
        mockURLSession.mockError = NSError(domain: "network", code: NSURLErrorTimedOut, userInfo: nil)
    
        let networkUtil: NetworkUtil = NetworkUtil(mockURLSession)
        let expectation = self.expectation(description: "Should return NSURLErrorBadURL error")
        
      
        networkUtil.get(url: "https://www.test.com", params: nil) { (respond: URLResponse?, result: Any?) in
            XCTFail("Should not happen")
        } failure: { (error: NetworkError) in
            XCTAssertEqual(error.statusCode, NSURLErrorTimedOut)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //test Not Connected To Internet
    func testRequest_whenNotConnectedToInternet_returnNotConnectedToInternetErrorCode() {
        
        let mockURLSession: MockURLSession = MockURLSession()
        mockURLSession.mockError = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
    
        let networkUtil: NetworkUtil = NetworkUtil(mockURLSession)
        let expectation = self.expectation(description: "Should return NSURLErrorBadURL error")
        
      
        networkUtil.get(url: "https://www.test.com", params: nil) { (respond: URLResponse?, result: Any?) in
            XCTFail("Should not happen")
        } failure: { (error: NetworkError) in
            XCTAssertEqual(error.statusCode, NSURLErrorNotConnectedToInternet)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //test server response empty data
    func testRequest_whenResponseEmptyData_returnEmptyDataErrorMessage() {
        
        let mockURLSession: MockURLSession = MockURLSession()
        mockURLSession.mockData = nil;
        
        let networkUtil: NetworkUtil = NetworkUtil(mockURLSession)
        let expectation = self.expectation(description: "Should return 'empty data] error message")
        
        networkUtil.get(url: "https://www.test.com", params: nil) { (respond: URLResponse?, result: Any?) in
            XCTFail("Should not happen")
        } failure: { (error: NetworkError) in
            XCTAssertEqual(error.message, "empty data")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //test server response wrong json
    func testRequest_whenJSONDecodeError_returnDecodeErrorMessage() {
        
        let mockURLSession: MockURLSession = MockURLSession()
        guard let filePath = Bundle.main.url(forResource: "incorrectJsonData", withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
            return
        }
    
        mockURLSession.mockData = data;
 
        let networkUtil: NetworkUtil = NetworkUtil(mockURLSession)
        let expectation = self.expectation(description: "Should return JSON serialization error message")
        
        networkUtil.get(url: "https://www.test.com", params: nil) { (respond: URLResponse?, result: Any?) in
            XCTFail("Should not happen")
        } failure: { (error: NetworkError) in
            XCTAssertEqual(error.message, "JSON serialization error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
}
