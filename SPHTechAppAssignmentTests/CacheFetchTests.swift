//
//  CacheFetchTests.swift
//  SPHTechAppAssignmentTests
//
//  Created by apple on 2021/5/22.
//

import XCTest

class CacheFetchTests: XCTestCase {

    var cacheUtil: ApiCacheUtil!
    var cacheModeArray: [QuarterlyMobileDataUsage] = [QuarterlyMobileDataUsage]()
    
    override func setUpWithError() throws {
        let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.cacheUtil = ApiCacheUtil(saveURL: cacheDir.appendingPathComponent("testUrl"))
        
        let mode1 = QuarterlyMobileDataUsage()
        mode1.quarter = "2016-Q1"
        mode1.volumeOfMobileData = "0.001"
        
        let mode2 = QuarterlyMobileDataUsage()
        mode2.quarter = "2016-Q2"
        mode2.volumeOfMobileData = "0.002"
        
        let mode3 = QuarterlyMobileDataUsage()
        mode3.quarter = "2016-Q3"
        mode3.volumeOfMobileData = "0.003"
        
        cacheModeArray.append(mode1)
        cacheModeArray.append(mode2)
        cacheModeArray.append(mode3)
        
        self.cacheUtil.save(object: cacheModeArray)
    }

    //Test data cacche load
    func test_whenFetchCacheData_returnModeCountRight() {
        if let array: [QuarterlyMobileDataUsage] = self.cacheUtil .fetch() {
            XCTAssertEqual(array.count, cacheModeArray.count)
        } else {
            XCTFail("fetch cache error")
        }
    }
    
    
}
