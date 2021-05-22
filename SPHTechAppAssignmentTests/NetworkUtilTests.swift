//
//  NetworkUtilTests.swift
//  SPHTechAppAssignment
//
//  Created by apple on 2021/5/22.
//

import XCTest

class NetworkUtilTests: XCTestCase {
  
    func testRequest_whenBadURL_returnErrorCode() {
        
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
