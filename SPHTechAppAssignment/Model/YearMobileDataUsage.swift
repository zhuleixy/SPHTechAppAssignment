//
//  YearMobileDataUsage.swift
//  SwiftDemo
//
//  Created by zhulei on 2021/5/19.
//

import UIKit

class YearMobileDataUsage: MobileDataUsageProtocol {

    var year: String?
    var volumeOfMobileData: String?
    var isDecrease: Bool = false
    var quarterlyArray = [QuarterlyMobileDataUsage]();
    
    var timeUnit: String? {
        get {
            return self.year
        }
    }
    
    var volume: String? {
        get {
            return self.volumeOfMobileData
        }
    }
    
}
