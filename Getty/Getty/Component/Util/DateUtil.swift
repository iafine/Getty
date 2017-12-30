//
//  DateUtil.swift
//  Getty
//
//  Created by Hyyy on 2017/12/27.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

// MARK: - 日期相关工具类
extension Date {
    
    /// 日期 -> 日期字符串
    static func string(from: Date?, format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        
        if from == nil {
            return ""
        }
        return dateformatter.string(from: from!)
    }
    
    /// 日期字符串 -> 日期
    static func date(from: String, format: String) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        
        return dateformatter.date(from: from)
    }
    
    /// 计算两个时间之间差，返回分钟数
    static func minutesInterval(startDate: Date, endDate: Date) -> Int {
        // 对时间进行加工处理
        let startDate = Date.date(from: Date.string(from: startDate, format: "yyyy-MM-dd HH:mm"), format: "yyyy-MM-dd HH:mm")
        let endDate = Date.date(from: Date.string(from: endDate, format: "yyyy-MM-dd HH:mm"), format: "yyyy-MM-dd HH:mm")
        let timeInterval = endDate?.timeIntervalSince(startDate!)
        
        return Int(timeInterval! / 60)
    }
}
