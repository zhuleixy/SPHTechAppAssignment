//
//  QuarterlyMobileDataUsage.swift
//  SwiftDemo
//
//  Created by zhulei on 2021/5/18.
//

import UIKit

class QuarterlyMobileDataUsage : Codable, MobileDataUsageProtocol {
    var id: Int?
    var quarter: String?
    var volumeOfMobileData: String?
    
    var timeUnit: String? {
        get {
            return self.quarter
        }
    }
    
    var volume: String? {
        get {
            return self.volumeOfMobileData
        }
    }
    
    var isDecrease: Bool {
        get {
            return false
        }
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case quarter = "quarter"
//        case volumeOfMobileData = "volume_of_mobile_data"
//    }
}
