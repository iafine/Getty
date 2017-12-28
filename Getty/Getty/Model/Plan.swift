//
//  Plan.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class Plan: NSObject {

    var planID: Int = 0
    
    var planName: String = ""
    
    var startDate: Date? = nil
    
    var endDate: Date? = nil
    
    var durationTimes: Int = 0
    
    var notificationWeeks: String = "周一,周二,周三,周四,周五,周六,周日"
}

extension Plan {
    func weeksFormat() -> String {
        let weekArray = notificationWeeks.components(separatedBy: ",")
        
        // 每天
        if weekArray.contains("周一") &&
            weekArray.contains("周二") &&
            weekArray.contains("周三") &&
            weekArray.contains("周四") &&
            weekArray.contains("周五") &&
            weekArray.contains("周六") &&
            weekArray.contains("周日") {
            return "每天"
        }
        
        // 工作日
        if weekArray.contains("周一") &&
            weekArray.contains("周二") &&
            weekArray.contains("周三") &&
            weekArray.contains("周四") &&
            weekArray.contains("周五") {
            return "工作日"
        }
        
        return notificationWeeks
    }
}
