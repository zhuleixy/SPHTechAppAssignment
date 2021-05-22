//
//  DataTransverter.swift
//  SPHTechAppAssignment
//
//  Created by apple on 2021/5/22.
//

import UIKit

//Other unit of time conversion methods can be added here
//可以在此添加其他时间单位转换方法
class DataTransverter {
    
    static func convertQuarterlyDataToYearData(sourceData: [QuarterlyMobileDataUsage]) -> ([YearMobileDataUsage]) {
        
        var yearDataDic: [String : YearMobileDataUsage] = [String : YearMobileDataUsage]()
        
        var lastVolume : Double = 0
        
        for data: QuarterlyMobileDataUsage in sourceData {
            let lenth = data.quarter?.count ?? 0;
            if (data.quarter != nil && lenth >= 4) {
                let year: String = String(data.quarter!.prefix(4));
                let yearData: YearMobileDataUsage? = yearDataDic[year]
                if (yearData != nil) {
                    let currentVolumeDecimal: Decimal? = Decimal(string: yearData!.volumeOfMobileData ?? "0")
                    let additionalVolumeDecimal: Decimal? = Decimal(string: data.volumeOfMobileData ?? "0")
                    if currentVolumeDecimal != nil && additionalVolumeDecimal != nil {
                        let volumeOfYear: Decimal = currentVolumeDecimal! + additionalVolumeDecimal!
                        yearData?.volumeOfMobileData = NSDecimalNumber(decimal: volumeOfYear).stringValue
                    }
                    yearData?.quarterlyArray.append(data)
                    let additionalVolume: Double = Double(data.volumeOfMobileData!)!
                    if additionalVolume < lastVolume {
                        yearData?.isDecrease = true
                    }
                    lastVolume = additionalVolume
                } else {
                    let yearData: YearMobileDataUsage = YearMobileDataUsage()
                    yearData.year = year;
                    yearData.volumeOfMobileData = data.volumeOfMobileData
                    yearData.quarterlyArray.append(data)
                    yearDataDic[year] = yearData
                    lastVolume = Double(yearData.volumeOfMobileData!)!
                }
            }
        }
        
        var yearArray: [YearMobileDataUsage] = [YearMobileDataUsage]()
        
        let dictKeys = [String](yearDataDic.keys)
        let sortedKeys = dictKeys.sorted()
        
        for (key) in sortedKeys {
            guard let year = Int(key as String) else {
                continue
            }
            guard (year >= 2008 && year <= 2018) else {
                continue
            }
            let value = yearDataDic[key]
            if (value != nil) {
                yearArray.append(value!)
            }
        }
        return yearArray
    }
    
}
