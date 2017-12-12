//
//  NotificationManager.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit
import UserNotifications

@available(iOS 10.0, *)
class NotificationManager: NSObject {
    
    static let manager = NotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    /// 注册本地通知
    ///
    /// - Parameter completeHandler: 完成回调
    func registerLocalNotificationCompleteHandler(completeHandler: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
            UserDefaults.standard.set(true, forKey: Constant.Cache.kHasRegisterdNotificationKey)
            if (granted) {
                print("注册本地通知成功")
            }else {
                print("注册本地通知失败")
            }
            DispatchQueue.main.async {
                completeHandler(granted, error)
            }
        }
        
        let confirmAction = UNNotificationAction (identifier: Constant.Notification.Action.kPlanConfirmAction,
                                                  title: "开始计划",
                                                  options: .foreground)
        let refuseAction = UNNotificationAction (identifier: Constant.Notification.Action.kPlanRefuseAction,
                                                 title: "取消计划",
                                                 options: [.foreground, .destructive])
        let finishAction = UNNotificationAction (identifier: Constant.Notification.Action.kPlanFinishAction,
                                                 title: "进行打卡",
                                                 options: [.foreground, .destructive])
        
        let startCategory = UNNotificationCategory (identifier: Constant.Notification.Category.kPlanStartCategory,
                                                    actions: [confirmAction, refuseAction],
                                                    intentIdentifiers: [Constant.Notification.kPlanStartIdentifier],
                                                    options: .customDismissAction)
        let endCategory = UNNotificationCategory (identifier: Constant.Notification.Category.kPlanEndCategory,
                                                  actions: [finishAction],
                                                  intentIdentifiers: [Constant.Notification.kPlanEndIdentifier],
                                                  options: .customDismissAction)
        
        center .setNotificationCategories([startCategory, endCategory])
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
