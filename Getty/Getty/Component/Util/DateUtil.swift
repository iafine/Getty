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
}
