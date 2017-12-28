//
//  TipUtil.swift
//  Getty
//
//  Created by Hyyy on 2017/12/28.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class TipUtil: NSObject {
    
    /// 显示提示
    static func showDangerTip(title: String) {
        let banner = StatusBarNotificationBanner(title: title, style: .danger)
        banner.duration = 1.5
        banner.autoDismiss = true
        banner.show()
    }
}
