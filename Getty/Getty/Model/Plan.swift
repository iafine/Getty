//
//  Plan.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import Foundation
import RealmSwift

class Plan: Object {

    @objc dynamic var planName: String = ""
    
    @objc dynamic var startDate: Date?
    
    @objc dynamic var endDate: Date?
    
    @objc dynamic var durationTimes: Int = 0
    
    @objc dynamic var notificationWeeks: String = "星期一,星期二,星期三,星期四,星期五,星期六,星期日"
}

extension Plan {
    func weeksFormat() -> String {
        let weekArray = notificationWeeks.components(separatedBy: ",")
        
        // 每天
        if weekArray.contains("星期一") &&
            weekArray.contains("星期二") &&
            weekArray.contains("星期三") &&
            weekArray.contains("星期四") &&
            weekArray.contains("星期五") &&
            weekArray.contains("星期六") &&
            weekArray.contains("星期日") {
            return "每天"
        }
        
        // 工作日
        if weekArray.contains("星期一") &&
            weekArray.contains("星期二") &&
            weekArray.contains("星期三") &&
            weekArray.contains("星期四") &&
            weekArray.contains("星期五") {
            return "工作日"
        }
        
        return notificationWeeks
    }
}
