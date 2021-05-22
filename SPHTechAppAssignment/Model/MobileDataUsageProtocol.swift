//
//  MobileDataUsageProtocol.swift
//  SPHTechAppAssignment
//
//  Created by apple on 2021/5/22.
//

import UIKit

//Considering that the data may be presented in a month or other time units in the future, a protocol is defined here to facilitate cell presentation. Using DataConverter to transform data sources can easily switch between time periods
//考虑到以后可能以一个月或其他时间单位来展示数据，这里定义一个协议方便cell展示，使用DataConverter转换数据源可以轻松的切换时间段

protocol MobileDataUsageProtocol {
    var timeUnit: String? {get}
    var volume: String? {get}
    var isDecrease: Bool {get}
}
